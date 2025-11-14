//
//  CookbookRecipe.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
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
