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
        // GeometryReader para controlar el ancho y evitar "zoom" excesivo
        GeometryReader { geometry in
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
                                .frame(width: geometry.size.width, height: 300)
                                .clipped()
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
                                startPoint: .center,
                                endPoint: .bottom
                            )
                            .frame(width: geometry.size.width, height: 300)
                            
                            Text(recipe.title)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .padding(.bottom, 10)
                                .frame(width: geometry.size.width, alignment: .leading)
                            
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
                            .frame(width: geometry.size.width)
                        }
                        .frame(width: geometry.size.width, height: 300)
                        
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
                                        .foregroundColor(.primary)
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
                                    .foregroundColor(.primary)
                                    .opacity(0.8)
                                    .lineSpacing(4)
                            }
                            
                            // --- SECCIÓN: NO CONTIENE (LIBRE DE) ---
                            if !recipe.freeFromAllergens.isEmpty {
                                Divider()
                                VStack(alignment: .leading) {
                                    Text("No contiene:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    HStack {
                                        ForEach(recipe.freeFromAllergens, id: \.self) { allergen in
                                            // CAMBIO: Usamos .spanishName en lugar de rawValue
                                            Text(allergen.spanishName)
                                                .font(.caption)
                                                .padding(5)
                                                .background(Color.green.opacity(0.2))
                                                .cornerRadius(5)
                                        }
                                    }
                                }
                            }
                            
                            // --- SECCIÓN: CONTIENE (ALÉRGENOS) ---
                            if !recipe.containsAllergens.isEmpty {
                                Divider()
                                VStack(alignment: .leading) {
                                    Text("Contiene:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    HStack {
                                        ForEach(recipe.containsAllergens, id: \.self) { allergen in
                                            // CAMBIO: Usamos .spanishName en lugar de rawValue
                                            Text(allergen.spanishName)
                                                .font(.caption)
                                                .padding(5)
                                                .background(Color.orange.opacity(0.2))
                                                .cornerRadius(5)
                                        }
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(25)
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(30)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 20)
                        .padding(.top, -20)
                    }
                }
                .ignoresSafeArea(edges: .top)
            }
        }
        .navigationBarHidden(true)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: .constant(recipeList[0]))
    }
}
