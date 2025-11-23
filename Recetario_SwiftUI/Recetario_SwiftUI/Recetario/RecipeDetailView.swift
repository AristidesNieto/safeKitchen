//
//  RecipeDetailView.swift
//  Recetario_SwiftUI
//
//  Created by Administrador on 23/11/25.
//

// Archivo: RecipeDetailView.swift
/*import SwiftUI

struct RecipeDetailView: View {
    // Usamos Binding para que si le das "Favorite" aquí, se actualice en la lista también
    @Binding var recipe: CookbookRecipe
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // 1. Imagen principal grande
                Image(recipe.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped()
                    .overlay(alignment: .topLeading) {
                        // Botón de regresar flotante sobre la imagen
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.black) // O .white dependiendo de tus fotos
                                .padding(10)
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .padding(.top, 50) // Espacio para barra de estado
                        .padding(.leading, 20)
                    }

                VStack(alignment: .leading, spacing: 20) {
                    // 2. Título y Favorito
                    HStack {
                        Text(recipe.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            recipe.isFavorite.toggle()
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                .font(.title)
                                .foregroundColor(recipe.isFavorite ? .red : .gray)
                        }
                    }
                    
                    Divider()
                    
                    // 3. Lista de Ingredientes (Completa)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredientes")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            HStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6))
                                    .foregroundColor(.blue)
                                Text(ingredient)
                                    .font(.body)
                            }
                        }
                    }
                    
                    Divider()
                    
                    // 4. Instrucciones / Preparación
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Preparación")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(recipe.instructions)
                            .font(.body)
                            .lineSpacing(6) // Hace el texto más legible
                            .foregroundColor(.secondary)
                    }
                }
                .padding(20)
                .background(Color.white)
                // Efecto visual para que el contenido se solape un poco con la imagen
                .cornerRadius(30)
                .offset(y: -30)
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true) // Ocultamos la barra nativa para usar nuestro botón
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview con datos falsos
        RecipeDetailView(recipe: .constant(recipeList[0]))
    }
}
*/
