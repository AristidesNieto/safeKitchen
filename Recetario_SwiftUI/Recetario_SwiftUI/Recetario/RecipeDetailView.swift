//
//  RecipeDetailView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: CookbookRecipe
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // Fondo Azul
            Color(red: 0.4, green: 0.5, blue: 1.0)
                .opacity(0.9)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    // 1. Cabecera Imagen
                    ZStack(alignment: .bottomLeading) {
                        recipe.getImage()
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                        
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        
                        Text(recipe.title)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .padding(.bottom, 10)
                        
                        // Botones navegación
                        VStack {
                            HStack {
                                Button(action: { dismiss() }) {
                                    Image(systemName: "chevron.left")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.black.opacity(0.3))
                                        .clipShape(Circle())
                                }
                                Spacer()
                                Button(action: { recipe.isFavorite.toggle() }) {
                                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                        .font(.title2)
                                        .foregroundColor(.red)
                                        .padding()
                                        .background(Color.white.opacity(0.8))
                                        .clipShape(Circle())
                                }
                            }
                            .padding(.top, 50)
                            .padding(.horizontal)
                            Spacer()
                        }
                    }
                    .frame(height: 300)
                    
                    // 2. Tarjeta de Contenido
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Ingredientes
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ingredientes")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.8))
                            
                            ForEach(recipe.ingredients, id: \.self) { ingredient in
                                Text("• \(ingredient)")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.primary) // CAMBIO: .black -> .primary
                            }
                        }
                        
                        Divider()
                        
                        // Instrucciones
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Preparación")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.8))
                            
                            Text(recipe.instructions)
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.primary) // CAMBIO: .black -> .primary
                                .opacity(0.8) // Opacidad aplicada por separado
                                .lineSpacing(4)
                        }
                        
                        // --- NUEVA SECCIÓN: NO CONTIENE (LIBRE DE) ---
                        if !recipe.freeFromAllergens.isEmpty {
                            Divider()
                            VStack(alignment: .leading) {
                                Text("No contiene:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                HStack {
                                    ForEach(recipe.freeFromAllergens, id: \.self) { allergen in
                                        Text(allergen.rawValue.capitalized)
                                            .font(.caption)
                                            .padding(5)
                                            // Fondo verde para indicar positivo/seguro
                                            .background(Color.green.opacity(0.2))
                                            .cornerRadius(5)
                                    }
                                }
                            }
                        }
                        
                        // Alertas de Alérgenos (Existente)
                        if !recipe.containsAllergens.isEmpty {
                            Divider()
                            VStack(alignment: .leading) {
                                Text("Contiene:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                HStack {
                                    ForEach(recipe.containsAllergens, id: \.self) { allergen in
                                        Text(allergen.rawValue.capitalized)
                                            .font(.caption)
                                            .padding(5)
                                            // Fondo naranja para alerta
                                            .background(Color.orange.opacity(0.2))
                                            .cornerRadius(5)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(25)
                    // CAMBIO CLAVE PARA EL FONDO DE LA TARJETA
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 20)
                    .padding(.top, -20)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarHidden(true)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: .constant(recipeList[0]))
    }
}
