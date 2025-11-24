//
//  RecipeListItemView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI

struct RecipeListItemView: View {
    @Binding var recipe: CookbookRecipe
    
    var body: some View {
        HStack(spacing: 15) {
            recipe.getImage()
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    // No ponemos color fijo, dejamos que SwiftUI decida (Negro o Blanco)
                
                Text("Ingredientes:")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary) // .secondary se adapta mejor que .gray
                
                ForEach(recipe.ingredients.prefix(3), id: \.self) { ingredient in
                    Text("• \(ingredient)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                if recipe.ingredients.count > 3 {
                    Text("...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
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
        // --- CAMBIO CLAVE PARA MODO OSCURO ---
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
    }
}

struct RecipeListItemView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State var recipe: CookbookRecipe
        var body: some View { RecipeListItemView(recipe: $recipe) }
    }

    static var previews: some View {
        VStack {
            PreviewWrapper(recipe: recipeList[0])
        }
        .padding()
        .background(Color(.systemGray6))
    }
}
