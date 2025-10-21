//
//  CookbookRecipe.swift
//  safeKitchen
//
//  Created by Aristides Nieto Guzman on 20/10/25.
//

import Foundation

// --- MODELO: Define la estructura de una receta ---
struct CookbookRecipe: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let ingredients: [String]
    var isFavorite: Bool
}
