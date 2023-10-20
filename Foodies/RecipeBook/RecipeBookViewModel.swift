//
//  RecipeBookViewModel.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/17/23.
//

import SwiftUI
import UIKit
import CoreData

class RecipeBookViewModel: ObservableObject {
    @Published var recipes: [CDRecipeBook]
    var selectedRecipeIndex: Int?
    private let persistentContainer: NSPersistentContainer
    
    init() {//Core Data implementation
        persistentContainer = NSPersistentContainer(name: "Foodies")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CDRecipeBook> = CDRecipeBook.fetchRequest()
        do {
            self.recipes = try context.fetch(fetchRequest)
            print("Fetched recipes: \(recipes)") // Add this line to log fetched recipes
        } catch {
            print("Error fetching recipes: \(error)")
            self.recipes = []
        }
    }
    
    //adds recipe to core data file/
    func addRecipe(name: String, ingredients: String, steps: String) {
        let context = persistentContainer.viewContext
        let recipe = CDRecipeBook(context: context)
        recipe.id = UUID()
        recipe.name = name
        let addIngredients = ingredients.components(separatedBy: ",")
        let addSteps = steps.components(separatedBy: ",")
        
        let ingredientsData = NSKeyedArchiver.archivedData(withRootObject: addIngredients)
        recipe.ingredients = ingredientsData as NSObject
        
        let stepsData = NSKeyedArchiver.archivedData(withRootObject: addSteps)
        recipe.steps = stepsData as NSObject
        
        recipes.append(recipe)
        
        saveContext()
    }
    
    //Called by editRecipeByName
    func editRecipe(at index: Int, name: String?, ingredients: String?, steps: String?) {
        let context = persistentContainer.viewContext
        let recipe = recipes[index]
        
        if let name = name {
            recipe.name = name
        }
        
        if let ingredients = ingredients {
            let ingredientsData = NSKeyedArchiver.archivedData(withRootObject: ingredients.components(separatedBy: ","))
            recipe.ingredients = ingredientsData as NSObject
        }
        
        if let steps = steps {
            let stepsData = NSKeyedArchiver.archivedData(withRootObject: steps.components(separatedBy: ","))
            recipe.steps = stepsData as NSObject
        }
        
        saveContext()
    }
    
    //edit recipe name(used in edit recipe view)
    func editRecipeByName(name: String, newName: String?, ingredients: String?, steps: String?) {
        if let index = search(query: name) {
            editRecipe(at: index, name: newName, ingredients: ingredients, steps: steps)
        }
    }

    //deletes Recipe given name of recipe
    func deleteRecipe(name: String) -> Int {
        let context = persistentContainer.viewContext
        if let index = search(query: name) {
            let recipe = recipes[index]
            context.delete(recipe)
            recipes.remove(at: index)
            selectedRecipeIndex = nil
            
            saveContext()
            
            return index
        } else {
            return -1
        }
    }
    
    //Searches recipe
    //Continued in Recipe row but given a valid recipe name
    //uses this function with the Recipe row file to highlight
    //name of recipe
    //Also used for edit,delet to find recipe index
    func search(query: String) -> Int? {
        if query.isEmpty {
            return nil
        }
        if let index = recipes.firstIndex(where: { recipe in
            if let name = recipe.name {
                return name.localizedCaseInsensitiveCompare(query) == .orderedSame
            } else {
                return false
            }
        }) {
            selectedRecipeIndex = index
            return index
        } else {
            return nil
        }
    }
    
    //saves to core data file
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    //Test func: deletes all recipes from core data file
    //
    //ONLY TO BE USED WHILE TESTING
    //COMPLETELY EMPTIES CORE DATA FILE
    func deleteAllRecipes() {
       let context = persistentContainer.viewContext
       let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDRecipeBook.fetchRequest()
       let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

       do {
           try context.execute(batchDeleteRequest)
           recipes.removeAll()
           saveContext()
       } catch {
           print("Error deleting all recipes: \(error)")
       }
   }
}
