//
//  RecipeRow.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/17/23.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: CDRecipeBook
    var searchText: String = ""
    
    private var highlightedName: some View {//using search changes text color to achieve highlighting
        if let range = recipe.name?.localizedStandardRange(of: searchText) {
            return Text(recipe.name![recipe.name!.startIndex..<range.lowerBound])
            + Text(recipe.name![range])
                .foregroundColor(.red) // Change text color to red
            + Text(recipe.name![recipe.name!.index(range.upperBound, offsetBy: 0)..<recipe.name!.endIndex])
        } else {
            return Text(recipe.name ?? "")
        }
    }
    
    var body: some View {//displays recipe name in tableview
        HStack {
            highlightedName
                .font(.headline)
            Spacer()
        }
    }
}
