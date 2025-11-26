//
//  CookbookRecipe.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import Foundation
import SwiftUI

enum Allergen: String, Codable {
    case shrimp, nuts, eggs, fish, gluten, soy, driedFruits, dairy
}

// --- MODELO HÍBRIDO ---
struct CookbookRecipe: Identifiable {
    let id: UUID
    let title: String
    
    let imageName: String?
    let imageData: Data?
    
    let ingredients: [String]
    let instructions: String
    
    let containsAllergens: [Allergen]
    // NUEVO: Lista de alérgenos que NO contiene (Seguro para...)
    let freeFromAllergens: [Allergen]
    
    var isFavorite: Bool
    
    // Init para recetas del SISTEMA (Usa Assets)
    init(title: String, imageName: String, ingredients: [String], instructions: String, containsAllergens: [Allergen], freeFromAllergens: [Allergen] = [], isFavorite: Bool) {
        self.id = UUID()
        self.title = title
        self.imageName = imageName
        self.imageData = nil
        self.ingredients = ingredients
        self.instructions = instructions
        self.containsAllergens = containsAllergens
        self.freeFromAllergens = freeFromAllergens
        self.isFavorite = isFavorite
    }
    
    // Init para recetas del USUARIO (Usa Data)
    init(id: UUID = UUID(), title: String, imageData: Data?, ingredients: [String], instructions: String, containsAllergens: [Allergen], freeFromAllergens: [Allergen] = [], isFavorite: Bool) {
        self.id = id
        self.title = title
        self.imageName = nil
        self.imageData = imageData
        self.ingredients = ingredients
        self.instructions = instructions
        self.containsAllergens = containsAllergens
        self.freeFromAllergens = freeFromAllergens
        self.isFavorite = isFavorite
    }
    
    func getImage() -> Image {
        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else if let name = imageName, !name.isEmpty {
            return Image(name)
        } else {
            return Image(systemName: "fork.knife.circle.fill")
        }
    }
    
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
