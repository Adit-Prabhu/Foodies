//
//  RecipeListViewModel.swift
//  Foodies
//let apiKey = "07b32be3fe2c47809ca74025e69b2b24"
//  Created by Adit Prabhu on 4/12/23.
//

import Foundation

class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []//api recipes are stored in this array

    func fetchRecipes(query: String) {//given a string query fetches recipes
        let apiKey = APIConfig.apiKey
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://recipe-by-api-ninjas.p.rapidapi.com/v1/recipe?query=\(encodedQuery)"

        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("recipe-by-api-ninjas.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching recipes: \(error)")
                return
            }

            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let recipes = try decoder.decode([Recipe].self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = recipes
                    }
                } catch {
                    print("Error decoding recipes: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func deleteRecipe(at offsets: IndexSet) {//delete api recipe from list
        recipes.remove(atOffsets: offsets)
    }
}
