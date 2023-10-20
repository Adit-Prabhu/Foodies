//
//  RecipeAPIDetailView.swift
//  Foodies
//
//  Created by Adit Prabhu on 4/13/23.
//

import SwiftUI

struct RecipeAPIDetailView: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(recipe.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Divider()
                Text("Ingredients:")//lists ingredients by dividing string by "|"
                    .font(.headline)//uses LazyVGrid to make the items flexible
                    .foregroundColor(.black)
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 8) {
                    ForEach(recipe.ingredients.split(separator: "|").map(String.init), id: \.self) { ingredient in
                        Text(ingredient)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom)
                
                Text("Serving:")//serving size
                    .font(.headline)
                    .foregroundColor(.black)
                Text(recipe.servings)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black)
                    .cornerRadius(10)

                Text("Steps:")//lists out steps 
                    .font(.headline)
                    .foregroundColor(.black)
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.instructions)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text(recipe.title), displayMode: .inline)
        }
    }
}
