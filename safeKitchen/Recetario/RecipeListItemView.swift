//
//  RecipeListItemView.swift
//  safeKitchen
//
//  Created by Aristides Nieto Guzman on 20/10/25.
//

import SwiftUI

// --- VISTA DE COMPONENTE: Dibuja una sola tarjeta de receta ---
struct RecipeListItemView: View {
    @Binding var recipe: CookbookRecipe
    
    var body: some View {
        HStack(spacing: 15) {
            Image(recipe.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Ingredientes:")
                    .font(.caption)
                    .fontWeight(.semibold)
                
                // Muestra solo los primeros 3 ingredientes
                ForEach(recipe.ingredients.prefix(3), id: \.self) { ingredient in
                    Text("• \(ingredient)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                if recipe.ingredients.count > 3 {
                    Text("...")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // Botón de favorito alineado abajo
            VStack {
                Spacer()
                Button(action: {
                    recipe.isFavorite.toggle()
                }) {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(recipe.isFavorite ? .red : .gray)
                        .font(.title2)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
    }
}
struct RecipeListItemView_Previews: PreviewProvider {
    // Creamos una variable @State con un dato de ejemplo para poder pasar el Binding
    @State static var previewRecipe = CookbookRecipe(
        title: "Res y Broccoli",
        imageName: "receta2",
        ingredients: ["Carne de Res", "Broccoli", "Arroz", "Ajonjolí"],
        isFavorite: true
    )

    static var previews: some View {
        RecipeListItemView(recipe: $previewRecipe)
            .padding()
            .background(Color(.systemGray6))
    }
}
