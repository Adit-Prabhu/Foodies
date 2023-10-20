//
//  MapModel.swift
//  Foodies
//
//  Created by Adit Prabhu on 4/22/23.
//

import Foundation
import SwiftUI
import CoreLocation

//Map Model
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
    let address: String
    let coordinate: CLLocationCoordinate2D
}
