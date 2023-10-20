//
//  SpoonacularStruct.swift
//  Foodies
//
//  Created by Adit Prabhu on 4/12/23.
//
import Foundation

//Recipe API struct
struct Recipe: Codable, Identifiable {
    let id = UUID()
    let title: String
    let ingredients: String
    let servings: String
    let instructions: String
}

typealias Ingredient = String

