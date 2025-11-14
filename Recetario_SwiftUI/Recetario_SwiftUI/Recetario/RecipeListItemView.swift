//
//  RecipeListItemView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
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

// --- PREVISUALIZACIÓN PARA CANVAS DE SWIFTUI ---
struct RecipeListItemView_Previews: PreviewProvider {

    // --- ARREGLO: Creamos una vista "envoltorio" (wrapper) ---
    // Esta vista SÍ puede tener @State, porque no es 'static'
    // y la usamos solo para el preview.
    struct PreviewWrapper: View {
        @State var recipe: CookbookRecipe
        
        var body: some View {
            RecipeListItemView(recipe: $recipe)
        }
    }

    static var previews: some View {
        // Ahora el preview usa el Wrapper
        VStack(spacing: 20) {
            Text("Tarjeta Favorita:")
            PreviewWrapper(recipe: CookbookRecipe(
                title: "Res y Broccoli",
                imageName: "receta2",
                ingredients: ["Carne de Res", "Broccoli", "Arroz", "Ajonjolí"],
                isFavorite: false
            ))
            
            Text("Tarjeta No Favorita:")
            PreviewWrapper(recipe: CookbookRecipe(
                title: "Ensalada de Pollo",
                imageName: "receta_ensalada",
                ingredients: ["Pollo", "Lechuga", "Tomate", "Aguacate"],
                isFavorite: false
            ))
        }
        .padding()
        .background(Color(.systemGray6))
    }
}
