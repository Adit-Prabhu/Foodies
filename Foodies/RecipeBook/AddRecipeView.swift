//
//  AddRecipeView.swift
//  Foodies
//
//  Created by Adit Prabhu on 4/12/23.
//
import SwiftUI
import CoreData

struct AddRecipeView: View {
    @Binding var isAddRecipeAlertPresented: Bool
    @State private var addRecipeName = ""
    @State private var addRecipeIngredients = ""
    @State private var addRecipeSteps = ""

    @EnvironmentObject var viewModel: RecipeBookViewModel
    
    //Add recipe takes name, ingredients and steps and calls add func
    //this view file takes care of the formatting of add recipe view
    var body: some View {
        VStack(spacing: 16) {
            Text("Add Recipe")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Recipe Name", text: $addRecipeName)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Ingredients(comma separated)", text: $addRecipeIngredients)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Steps(comma separated)", text: $addRecipeSteps)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Button("Cancel") {
                    isAddRecipeAlertPresented = false
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.red)
                .cornerRadius(10)
                
                Spacer()
                
                Button("Add") {
                    viewModel.addRecipe(name: addRecipeName, ingredients: addRecipeIngredients, steps: addRecipeSteps)
                    addRecipeName = ""
                    addRecipeIngredients = ""
                    addRecipeSteps = ""
                    isAddRecipeAlertPresented = false
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.black)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(isAddRecipeAlertPresented: .constant(true))
            .environmentObject(RecipeBookViewModel())
    }
}
