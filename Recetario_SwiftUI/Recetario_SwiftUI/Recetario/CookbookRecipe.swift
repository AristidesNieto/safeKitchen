//
//  CookbookRecipe.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import Foundation
import SwiftUI // Necesario para Image e UIImage

enum Allergen: String, Codable {
    case shrimp, nuts, eggs, fish, gluten, soy, driedFruits, dairy
}

// --- MODELO HÍBRIDO: Soporta recetas fijas y del usuario ---
struct CookbookRecipe: Identifiable {
    let id: UUID
    let title: String
    
    // Opción A: Imagen de Asset (Receta del sistema)
    let imageName: String?
    // Opción B: Datos de Imagen (Foto del usuario)
    let imageData: Data?
    
    let ingredients: [String]
    let instructions: String
    let containsAllergens: [Allergen]
    var isFavorite: Bool
    
    // Init para recetas del SISTEMA (Usa Assets)
    init(title: String, imageName: String, ingredients: [String], instructions: String, containsAllergens: [Allergen], isFavorite: Bool) {
        self.id = UUID()
        self.title = title
        self.imageName = imageName
        self.imageData = nil // No hay datos, es un asset
        self.ingredients = ingredients
        self.instructions = instructions
        self.containsAllergens = containsAllergens
        self.isFavorite = isFavorite
    }
    
    // Init para recetas del USUARIO (Usa Data)
    init(id: UUID = UUID(), title: String, imageData: Data?, ingredients: [String], instructions: String, containsAllergens: [Allergen], isFavorite: Bool) {
        self.id = id
        self.title = title
        self.imageName = nil // No es un asset
        self.imageData = imageData
        self.ingredients = ingredients
        self.instructions = instructions
        self.containsAllergens = containsAllergens
        self.isFavorite = isFavorite
    }
    
    // Helper para obtener la imagen correcta en la Vista
    func getImage() -> Image {
        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else if let name = imageName, !name.isEmpty {
            return Image(name)
        } else {
            // Imagen por defecto si falla todo (puedes poner un logo tuyo aquí)
            return Image(systemName: "fork.knife.circle.fill")
        }
    }
    
    // Lógica de Seguridad (Igual que antes)
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
