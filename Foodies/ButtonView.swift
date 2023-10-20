//
//  ButtonView.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/16/23.
//

import SwiftUI
import Foundation

//Basic formatting of all buttons in this project
//Has a black in fill with a bold white button icon
//Takes in action as a param to be reusable in different files
struct ButtonView: View {
    var backgroundColor: Color = .black
    var foregroundColor: Color = .white
    var systemName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(foregroundColor)
                .padding()
                .background(backgroundColor)
                .clipShape(Circle())
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}
