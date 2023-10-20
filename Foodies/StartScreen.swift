//
//  StartScreen.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/14/23.
//

import SwiftUI
import CoreData

//start screen shows foodies logo and three buttons to three main views
struct StartScreen: View {
    @State private var showMapScreen = false
    @State private var showRecipeBookScreen = false
    @State private var showRecipesOnlineScreen = false
    
    var body: some View {
        ZStack {
            Color(hex: 0x0D0D0D)//hex color for background
                .ignoresSafeArea()
            
            VStack {
                Image("foodiesLogo")//foodies logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 275)
                    .padding(.top, 80)
                
                Spacer()
                
                Button(action: {//shows map view
                    showMapScreen.toggle()
                }) {
                    Text("Explore Restaurants             ")
                        .foregroundColor(.black)
                        .font(.title2)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .frame(width: 600, height: 100)
                .padding(.bottom, 20)
                
                Button(action: {//shows recipe api view
                    showRecipesOnlineScreen.toggle()
                }) {
                    Text("Explore Recipes Online        ")
                        .foregroundColor(.black)
                        .font(.title2)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .frame(width: 600, height: 50)
                .padding(.bottom, 45)
                
                Button(action: {//shows recipe book view
                    showRecipeBookScreen.toggle()
                }) {
                    Text("Recipe Book                           ")
                        .foregroundColor(.black)
                        .font(.title2)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .frame(width: 600, height: 50)
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showMapScreen) {
            MapScreen()
        }
        .fullScreenCover(isPresented: $showRecipesOnlineScreen) {
            RecipeAPIView()
        }
        .fullScreenCover(isPresented: $showRecipeBookScreen) {
            RecipeBookView()
                .environmentObject(RecipeBookViewModel())
        }
    }
}

extension Color {//extension for the dark grey color used in startscreen background
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}

