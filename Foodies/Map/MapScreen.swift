//
//  MapScreen.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/14/23.
//

import SwiftUI
import MapKit
import Contacts
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var region = MKCoordinateRegion()
    @Published var lastLocationUpdateTime: Date? = nil
    private var timer: Timer? = nil//timer to refresh map

    override init() {//gets user location
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        startTimer()
    }

    private func startTimer() {//timer of 60 sec after which map refreshes
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.locationManager.startUpdatingLocation()
        }
    }
    
    //centers around user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            lastLocationUpdateTime = Date()
            locationManager.stopUpdatingLocation()
        }
    }
}

struct MapScreen: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @State private var searchText = ""
    
    @State private var markers = [Location]()
    
    @State private var selectedLocation: Location?
    @State private var isActive = false
    
    private func search() {//upon search lists nearby restaurants
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = locationManager.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else { return }
            
            markers = response.mapItems.map { item in
                let address = item.placemark.postalAddress.flatMap {
                    CNPostalAddressFormatter.string(from: $0, style: .mailingAddress)
                }
                return Location(name: item.name ?? "",
                                phone: item.phoneNumber ?? "",
                                address: address ?? "",
                                coordinate: item.placemark.coordinate)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {//Shows map and map annotations
                Map(coordinateRegion: $locationManager.region,
                    interactionModes: .all,
                    annotationItems: markers,
                    annotationContent: { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Button(action: { selectedLocation = location }) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.black)
                        }
                    }
                }
                )
                .ignoresSafeArea()
                
                VStack {//search bar
                    SearchBar(text: $searchText, action: search)
                        .padding(.top)
                    
                    Spacer()
                }
                
                //if pin is pressed show detail view of that restaurant
                if let selectedLocation = selectedLocation {
                    DetailView(location: selectedLocation) { self.selectedLocation = nil }
                        .transition(.move(edge: .bottom))
                }
            }
            .toolbar {//home button
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink(destination: StartScreen(), isActive: $isActive) {
                        ButtonView(systemName: "house") {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct MapScreen_Previews: PreviewProvider{
    static var previews: some View{
        MapScreen()
    }
}
