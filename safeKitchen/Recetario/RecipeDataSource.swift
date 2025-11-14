//
//  RecipeDataSource.swift
//  safeKitchen
//
//  Created by Aristides Nieto Guzman on 20/10/25.
//

import Foundation

// --- FUENTE DE DATOS: Provee la lista de recetas ---
let recipeList = [
    CookbookRecipe(title: "Ensalada de pollo", imageName: "receta4", ingredients: ["Pollo", "Lechuga", "Tomate", "Aguacate"], isFavorite: false),
    CookbookRecipe(title: "Hot-cakes de avena", imageName: "receta1", ingredients: ["Avena", "Plátano", "Huevo", "Leche"], isFavorite: false),
    CookbookRecipe(title: "Res y Broccoli", imageName: "receta2", ingredients: ["Carne de Res", "Broccoli", "Arroz", "Ajonjolí"], isFavorite: true),
    CookbookRecipe(title: "Wrap de Atún", imageName: "receta3", ingredients: ["Atún", "Pan pita", "Cebolla", "Aguacate"], isFavorite: true),
    CookbookRecipe(title: "Japanese Fried Chicken", imageName: "receta_pollo_frito", ingredients: ["Pollo", "Harina", "Soya", "Jengibre"], isFavorite: false)
]
