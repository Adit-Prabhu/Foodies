//
//  DeleteRecipeView.swift
//  Foodies
//
//  Created by Adit Prabhu on 4/12/23.
//
//  Deprecated File: Delete Recipe View
//  Deprecated since swipe to delete was used
//  Kept for future use

import SwiftUI
import CoreData

struct DeleteRecipeView: View {
    @Binding var isDeleteRecipeAlertPresented: Bool
    @State private var deleteRecipeName = ""

    @EnvironmentObject var viewModel: RecipeBookViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Delete Recipe")
                .font(.title)
                .fontWeight(.bold)

            TextField("Recipe Name", text: $deleteRecipeName)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            HStack {
                Button("Cancel") {
                    isDeleteRecipeAlertPresented = false
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.red)
                .cornerRadius(10)

                Spacer()

                Button("Delete") {
                    let index = viewModel.deleteRecipe(name: deleteRecipeName)
                    if index != -1 {
                        print("Deleted recipe at index: \(index)")
                    } else {
                        print("Recipe not found")
                    }
                    deleteRecipeName = ""
                    isDeleteRecipeAlertPresented = false
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

struct DeleteRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteRecipeView(isDeleteRecipeAlertPresented: .constant(true))
            .environmentObject(RecipeBookViewModel())
    }
}
