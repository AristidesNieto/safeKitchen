//
//  RecipeDataSource.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import Foundation

// --- FUENTE DE DATOS: Lista completa extraída de los documentos ---
let recipeList = [
    
    // MARK: - RECETAS DULCES
    CookbookRecipe(
        title: "Cake Pops Halloween",
        imageName: "receta4",
        ingredients: ["165g Harina", "250ml Jugo naranja", "Azúcar", "Chocolate apto", "Aceite girasol"],
        instructions: "1. Precalentar horno 180ºC. Mezclar aceite, azúcar y ralladura.\n2. Incorporar jugo y harina tamizada.\n3. Hornear 30 min.\n4. Desmenuzar con queso vegano, formar bolas y enfriar.\n5. Cubrir con chocolate.",
        containsAllergens: [.gluten],
        isFavorite: false
    ),
    CookbookRecipe(
        title: "Creme Brule Avena",
        imageName: "receta1",
        ingredients: ["2 tazas leche avena", "Azúcar", "Maicena", "Vainilla"],
        instructions: "1. Licuar todos los ingredientes.\n2. Calentar a fuego medio hasta espesar (5 min).\n3. Refrigerar en moldes.\n4. Caramelizar azúcar encima antes de servir.",
        containsAllergens: [.gluten],
        isFavorite: false // Antes true
    ),
    CookbookRecipe(
        title: "Mini Brownie Express",
        imageName: "receta4",
        ingredients: ["1 plátano maduro", "Harina de maíz", "Leche de soya", "Cacao", "Aceite"],
        instructions: "1. Machacar el plátano.\n2. Mezclar con el resto de ingredientes.\n3. Cocinar 2 minutos en microondas.",
        containsAllergens: [.soy],
        isFavorite: false
    ),
    CookbookRecipe(
        title: "Galletas Chispas",
        imageName: "receta4",
        ingredients: ["Aceite oliva", "Azúcar", "Harina trigo", "Leche soya", "Chips chocolate"],
        instructions: "1. Batir aceite con azúcares y leche.\n2. Añadir harina y chips.\n3. Formar bolitas y hornear a 180ºC por 12-15 min.",
        containsAllergens: [.gluten, .soy],
        isFavorite: false // Antes true
    ),
    CookbookRecipe(
        title: "Bizcocho Esponjoso",
        imageName: "receta1",
        ingredients: ["Leche vegetal", "Harina trigo", "Aceite oliva", "Azúcar", "Levadura"],
        instructions: "1. Batir leche, azúcar y aceite.\n2. Añadir harina y levadura.\n3. Hornear a 180ºC por 30 min.",
        containsAllergens: [.gluten, .soy],
        isFavorite: false
    ),
    CookbookRecipe(
        title: "Tarta de Manzana",
        imageName: "receta1",
        ingredients: ["Harina integral", "Margarina", "Manzanas", "Azúcar", "Pasas"],
        instructions: "1. Mezclar margarina con harina y agua para la masa.\n2. Colocar en molde.\n3. Rellenar con manzanas y hornear 30 min a 190ºC.",
        containsAllergens: [.gluten, .driedFruits],
        isFavorite: false // Antes true
    ),
    CookbookRecipe(
        title: "Galletas Navideñas",
        imageName: "receta4",
        ingredients: ["Harina sin gluten", "Harina arroz", "Linaza", "Mantequilla vegana", "Especias"],
        instructions: "1. Mezclar linaza con agua.\n2. Batir mantequilla con azúcar.\n3. Integrar todo y refrigerar 1h.\n4. Cortar formas y hornear 10 min a 175ºC.",
        containsAllergens: [],
        isFavorite: false
    ),
    CookbookRecipe(
        title: "Pancakes Sin Leche",
        imageName: "receta1",
        ingredients: ["2 Huevos", "Puré plátano", "Harina almendra", "Proteína vegetal"],
        instructions: "1. Batir huevos, plátano y leche vegetal.\n2. Integrar secos (harinas).\n3. Cocinar en sartén caliente por ambos lados.",
        containsAllergens: [.eggs, .nuts],
        isFavorite: false
    ),
    
    // MARK: - RECETAS SALADAS
    CookbookRecipe(
        title: "Masa de Hojaldre",
        imageName: "receta3",
        ingredients: ["500g Harina trigo", "400g Margarina vegana", "Agua fría", "Sal"],
        instructions: "1. Amasar harina, sal y agua. Reposar.\n2. Estirar masa y colocar margarina en centro.\n3. Doblar y estirar varias veces refrigerando entre cada vuelta.",
        containsAllergens: [.gluten],
        isFavorite: false
    ),
    CookbookRecipe(
        title: "Empanada de Atún",
        imageName: "receta3",
        ingredients: ["Masa hojaldre", "Atún", "Champiñones", "Tomate frito", "Aceitunas"],
        instructions: "1. Sofreír champiñones, cebolla y atún.\n2. Rellenar la masa de hojaldre.\n3. Hornear a 220ºC por 35 min.",
        containsAllergens: [.gluten, .fish],
        isFavorite: false // Antes true
    ),
    CookbookRecipe(
        title: "Mayonesa Sin Huevo",
        imageName: "receta_ensalada",
        ingredients: ["Aceite vegetal", "Leche de soya", "Vinagre", "Sal"],
        instructions: "1. Poner todo en vaso batidor.\n2. Batir sin mover del fondo hasta emulsionar.\n3. Mover suavemente hasta integrar.",
        containsAllergens: [.soy],
        isFavorite: false
    ),
    CookbookRecipe(
        title: "Pizza Vegetal",
        imageName: "receta3",
        ingredients: ["Harina trigo", "Levadura", "Tofu o queso vegano", "Vegetales varios"],
        instructions: "1. Hacer masa con harina, agua y levadura.\n2. Estirar y cubrir con salsa y vegetales.\n3. Hornear a 220ºC por 20 min.",
        containsAllergens: [.gluten, .soy],
        isFavorite: false // Antes true
    ),
    CookbookRecipe(
        title: "Albóndigas en Salsa",
        imageName: "receta2",
        ingredients: ["Carne picada", "Pan molido sin gluten", "Leche avena", "Verduras"],
        instructions: "1. Mezclar carne con pan, leche y especias.\n2. Formar bolas y hornear 20 min.\n3. Cocinar en salsa de verduras y vino.",
        containsAllergens: [.gluten],
        isFavorite: false
    ),
    CookbookRecipe(
        title: "Lasaña Sin Lácteos",
        imageName: "receta2",
        ingredients: ["Placas lasaña", "Carne picada", "Leche soya", "Verduras"],
        instructions: "1. Preparar boloñesa con carne y verduras.\n2. Hacer bechamel con leche de soya y harina.\n3. Montar capas y hornear.",
        containsAllergens: [.gluten, .soy],
        isFavorite: false
    ),
    CookbookRecipe(
        title: "Crema Cilantro",
        imageName: "receta2",
        ingredients: ["Brócoli", "Espinaca", "Cilantro", "Leche coco"],
        instructions: "1. Cocer brócoli.\n2. Licuar con espinaca, cilantro y leche coco.\n3. Calentar y servir.",
        containsAllergens: [],
        isFavorite: false // Antes true
    ),
    CookbookRecipe(
        title: "Pollo Relleno",
        imageName: "receta4",
        ingredients: ["Pechugas pollo", "Espinacas", "Aguacate", "Nueces"],
        instructions: "1. Abrir pechugas.\n2. Rellenar con mezcla de espinaca, aguacate y nueces.\n3. Dorar en sartén y terminar en horno.",
        containsAllergens: [.nuts],
        isFavorite: false // Antes true
    )
]
