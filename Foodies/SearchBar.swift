//
//  SearchBar.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/14/23.
//

import SwiftUI

//search bar formatting used in all three main views
//has a search bar with a magnifying glass in the end which acts as a button
//Takes in action as a param to be reusable in different files
struct SearchBar: View {
    @Binding var text: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            
            TextField("Search", text: $text)
                .padding(7)
                .background(Color(.white))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Spacer()
                        
                        Button(action: action) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 10)
                    }
                )
                .frame(width: 300)
            
            Spacer()
                .frame(width: 20)
        }
        .background(Color(.white))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}
