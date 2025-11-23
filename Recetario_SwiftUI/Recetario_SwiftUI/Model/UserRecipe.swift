//
//  UserRecipe.swift
//  Recetario_SwiftUI
//
//  Created by Administrador on 23/11/25.
//

//
//  UserRecipe.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 23/11/25.
//

import Foundation
import SwiftData

@Model
class UserRecipe {
    @Attribute(.unique) var id: UUID
    var title: String
    var imageData: Data? // Aquí guardamos la foto como bytes
    var ingredients: [String]
    var instructions: String
    var containsAllergens: [Allergen]
    var isFavorite: Bool
    
    init(title: String, imageData: Data?, ingredients: [String], instructions: String, containsAllergens: [Allergen]) {
        self.id = UUID()
        self.title = title
        self.imageData = imageData
        self.ingredients = ingredients
        self.instructions = instructions
        self.containsAllergens = containsAllergens
        self.isFavorite = false
    }
    
    // Función para convertir este modelo de BD a tu estructura visual (CookbookRecipe)
    func toCookbookRecipe() -> CookbookRecipe {
        return CookbookRecipe(
            id: self.id,
            title: self.title,
            imageData: self.imageData,
            ingredients: self.ingredients,
            instructions: self.instructions,
            containsAllergens: self.containsAllergens,
            isFavorite: self.isFavorite
        )
    }
}
