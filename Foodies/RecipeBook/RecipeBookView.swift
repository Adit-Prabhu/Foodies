//
//  RecipeBookView.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/16/23.
//

import SwiftUI
import CoreData

struct RecipeBookView: View {
    @EnvironmentObject var viewModel: RecipeBookViewModel
    
    @State private var searchText = "" 
    @State private var isAddRecipeAlertPresented = false
    @State private var isEditRecipeAlertPresented = false
    @State private var RecipeNotFoundAlert = false
    @State private var isActive = false
    @State private var showSwipeToDeleteAlert = false
    @State private var showAlertOnAppear = true
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Search bar
                    SearchBar(text: $searchText, action: {
                        viewModel.search(query: searchText)
                    })
                    .alert(isPresented: $showSwipeToDeleteAlert) {
                        Alert(title: Text("Swipe left to delete"), dismissButton: .default(Text("OK")) {
                            showAlertOnAppear = false
                        })
                    }
                    
                    // Recipe list
                    List {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeRow(recipe: recipe, searchText: searchText)
                            }
                            .swipeActions {//swipe to delete
                                Button(role: .destructive) {
                                    viewModel.deleteRecipe(name: recipe.name ?? "")
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Recipe Book")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {//add button
                            ButtonView(systemName: "plus") {
                                isAddRecipeAlertPresented = true
                            }
                            .padding(.trailing)
                            
                            //home button
                            NavigationLink(destination: StartScreen(), isActive: $isActive) {
                                ButtonView(systemName: "house") {
                                    isActive = true
                                }
                            }
                            .padding(.horizontal)
                            
                            //edit button
                            ButtonView(systemName: "pencil") {
                                isEditRecipeAlertPresented = true
                            }
                            .padding(.leading)
                        }
                    }
                }
                .onAppear {
                    if showAlertOnAppear {
                        showSwipeToDeleteAlert = true
                    }
                }
                .sheet(isPresented: $isAddRecipeAlertPresented) {
                    AddRecipeView(isAddRecipeAlertPresented: $isAddRecipeAlertPresented)
                        .environmentObject(viewModel)
                }
                .sheet(isPresented: $isEditRecipeAlertPresented) {
                    EditRecipeView(isEditRecipeAlertPresented: $isEditRecipeAlertPresented)
                        .environmentObject(viewModel)
                }
                .alert(isPresented: $RecipeNotFoundAlert) {
                    Alert(title: Text("Recipe not found"), message: Text("The selected recipe could not be found."), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

struct RecipeBookView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBookView()
            .environmentObject(RecipeBookViewModel())
    }
}
