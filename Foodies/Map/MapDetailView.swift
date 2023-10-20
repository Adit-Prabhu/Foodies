//
//  MapDetailView.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/14/23.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let location: Location
    let dismissAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(location.name)//restaurant name
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Spacer()

                Button(action: dismissAction) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.black)

            VStack(alignment: .leading, spacing: 8) {
                Text(location.address)//restaurant address
                    .font(.headline)
                    .foregroundColor(.gray)

                Text(location.phone)//restuarant phone address
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 350, alignment: .bottomLeading)
        .background(Color.white)
        .cornerRadius(16)
        .offset(y: UIScreen.main.bounds.height - 565)
    }
}
