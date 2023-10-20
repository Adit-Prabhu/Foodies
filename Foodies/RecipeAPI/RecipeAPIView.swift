//
//  RecipeAPIView.swift
//  Foodies
//
//  Created by Adit Prabhu on 4/12/23.
//

import SwiftUI

struct RecipeAPIView: View {
    @StateObject private var apiViewModel = RecipeListViewModel()
    @State private var query = ""
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {//search bar
                TextField("Enter recipe name", text: $query)
                    .padding()
                    .foregroundColor(.black)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {//upon button press fetches recipe
                    apiViewModel.fetchRecipes(query: query)
                }) {
                    Text("Fetch Recipes")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding([.leading, .trailing, .bottom])

                List {//lists each recipe in table view
                    ForEach(apiViewModel.recipes, id: \.id) { recipe in
                        NavigationLink(destination: RecipeAPIDetailView(recipe: recipe)) {
                            Text(recipe.title)
                                .font(.headline)
                                .padding()
                                .foregroundColor(.black)
                        }
                    }
                    .onDelete(perform: apiViewModel.deleteRecipe)
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("Recipes Online")
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

struct RecipeAPIView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeAPIView()
    }
}

