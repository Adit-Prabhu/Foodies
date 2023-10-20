//
//  EditRecipeView.swift
//  Foodies
//
//  Created by Adit Prabhu on 4/12/23.
//

import SwiftUI
import CoreData

struct EditRecipeView: View {
    @Binding var isEditRecipeAlertPresented: Bool
    @State private var editRecipeName = ""
    @State private var editRecipeIngredients = ""
    @State private var editRecipeSteps = ""
    @EnvironmentObject var viewModel: RecipeBookViewModel
    
    //Edit recipe takes name, ingredients and steps and calls edit func
    //If name is found then the edit takes place
    //If name is not found edit does not take place
    //this view file takes care of the formatting of edit recipe view
    var body: some View {
        VStack(spacing: 16) {
            Text("Edit Recipe")
                .font(.title)
            
            TextField("Recipe Name", text: $editRecipeName)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Ingredients(comma separated)", text: $editRecipeIngredients)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Steps(comma separated)", text: $editRecipeSteps)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Button("Cancel") {
                    isEditRecipeAlertPresented = false
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.red)
                .cornerRadius(10)
                
                Spacer()
                
                Button("Save"){
                    viewModel.editRecipeByName(name: editRecipeName, newName: editRecipeName.isEmpty ? nil : editRecipeName, ingredients: editRecipeIngredients.isEmpty ? nil : editRecipeIngredients, steps: editRecipeSteps.isEmpty ? nil : editRecipeSteps)
                    editRecipeName = ""
                    editRecipeIngredients = ""
                    editRecipeSteps = ""
                    isEditRecipeAlertPresented = false
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

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(isEditRecipeAlertPresented: .constant(true))
            .environmentObject(RecipeBookViewModel())
    }
}
