//
//  CookbookRecipe.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import Foundation

// --- ENUM: Alérgenos disponibles (Coinciden con tu UserProfile) ---
enum Allergen: String, Codable {
    case shrimp       // Camarón
    case nuts         // Nueces
    case eggs         // Huevos
    case fish         // Pescado
    case gluten       // Gluten
    case soy          // Soya
    case driedFruits  // Frutos secos
    case dairy        // Lácteos / Leche
}

// --- MODELO: Define la estructura de una receta ---
struct CookbookRecipe: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let ingredients: [String]
    let instructions: String
    
    // Lista de alérgenos que CONTIENE la receta
    let containsAllergens: [Allergen]
    
    var isFavorite: Bool
    
    // --- LÓGICA DE FILTRADO DE SEGURIDAD ---
    // Devuelve TRUE si la receta es segura para el usuario dado
    func isSafe(for user: UserProfile) -> Bool {
        if user.isAllergicToShrimp && containsAllergens.contains(.shrimp) { return false }
        if user.isAllergicToNuts && containsAllergens.contains(.nuts) { return false }
        if user.isAllergicToEggs && containsAllergens.contains(.eggs) { return false }
        if user.isAllergicToFish && containsAllergens.contains(.fish) { return false }
        if user.isAllergicToGluten && containsAllergens.contains(.gluten) { return false }
        if user.isAllergicToSoy && containsAllergens.contains(.soy) { return false }
        if user.isAllergicToDriedFruits && containsAllergens.contains(.driedFruits) { return false }
        if user.isAllergicToMilk && containsAllergens.contains(.dairy) { return false }
        
        return true
    }
}
