//
//  RecipeDetailView.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/17/23.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: CDRecipeBook
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(recipe.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                Divider()
                Text("Ingredients:")//recipe ingredients
                    .font(.headline)
                    .foregroundColor(.black)
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 8) {
                    ForEach(getIngredientsArray(), id: \.self) { ingredient in
                        Text(ingredient)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }

                Text("Steps:")//recipe steps
                    .font(.headline)
                ForEach(getStepsArray().enumerated().map({$0}), id: \.1) { index, step in
                    HStack(alignment: .top) {
                        Text("Step \(index + 1):")
                            .font(.subheadline)
                            .bold()
                        Text(step)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text(recipe.name ?? ""), displayMode: .inline)
        }
    }
    
    private func getIngredientsArray() -> [String] {//core data recipe ingredients translator
        if let data = recipe.ingredients as? Data {
            if let array = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
                return array
            }
        }
        return []
    }
    
    private func getStepsArray() -> [String] {//core data recipe steps translator
        if let data = recipe.steps as? Data {
            if let array = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
                return array
            }
        }
        return []
    }
}
