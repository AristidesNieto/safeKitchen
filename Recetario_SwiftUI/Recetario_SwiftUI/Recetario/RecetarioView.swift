//
//  RecetarioView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI
import SwiftData

// --- VISTA CONTENEDORA: Junta todos los componentes ---
struct RecetarioView: View {
    // 1. Obtenemos el usuario de SwiftData para saber sus alergias
    @Query var users: [UserProfile]
    
    // Fuente de datos local (en memoria para esta sesión)
    @State private var recipes = recipeList
    @State private var searchText: String = ""
    
    // NUEVO: Estado para controlar si mostramos solo favoritos
    @State private var showFavoritesOnly: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            // 1. El header azul
            RecetarioHeaderView()
            
            // 2. La barra de búsqueda (Pasamos el Binding del filtro)
            SearchBarView(searchText: $searchText, showFavoritesOnly: $showFavoritesOnly)
            
            // 3. La lista de tarjetas
            ScrollView {
                LazyVStack(spacing: 16) {
                    
                    // Si la lista filtrada está vacía, mostramos mensaje
                    if filteredRecipes.isEmpty {
                        ContentUnavailableView(
                            showFavoritesOnly ? "Sin favoritos" : "No se encontraron recetas",
                            systemImage: showFavoritesOnly ? "heart.slash" : "magnifyingglass",
                            description: Text(showFavoritesOnly ? "Marca algunas recetas como favoritas para verlas aquí." : "Intenta con otra búsqueda.")
                        )
                        .padding(.top, 50)
                        .foregroundColor(.gray)
                    } else {
                        // Iteramos sobre la lista filtrada
                        ForEach(filteredRecipes) { recipe in
                            // TRUCO VITAL:
                            // Necesitamos encontrar el índice real en la lista original 'recipes'
                            // para crear un Binding de escritura ($recipes[index]).
                            // Si usamos un binding constante, el botón de favorito no actualizará la vista.
                            if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
                                
                                NavigationLink(destination: RecipeDetailView(recipe: $recipes[index])) {
                                    RecipeListItemView(recipe: $recipes[index])
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
    }
    
    // Lógica de filtrado potente: Alergias + Búsqueda + Favoritos
    var filteredRecipes: [CookbookRecipe] {
        // 1. Obtenemos usuario (si no existe, uno dummy)
        let currentUser = users.first ?? UserProfile()
        
        return recipes.filter { recipe in
            // A. Seguridad (Alergias)
            let isSafe = recipe.isSafe(for: currentUser)
            
            // B. Búsqueda (Si texto vacío, pasa todo)
            let matchesSearch = searchText.isEmpty || recipe.title.localizedCaseInsensitiveContains(searchText)
            
            // C. Favoritos (Si el filtro está activo, solo pasan los favoritos)
            let matchesFavorite = !showFavoritesOnly || recipe.isFavorite
            
            return isSafe && matchesSearch && matchesFavorite
        }
    }
}

// --- Componentes auxiliares ---

struct RecetarioHeaderView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
            }
            
            Spacer()
            
            Button(action: {
                // Menú lateral (pendiente)
            }) {
                Image(systemName: "line.3.horizontal")
            }
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundColor(.white)
        .padding()
        .padding(.top, 40)
        .background(Color.blue)
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    // NUEVO: Recibimos el control del filtro
    @Binding var showFavoritesOnly: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            // Botón de Filtro (Ahora funcional)
            Button(action: {
                // Alternamos el estado con animación suave
                withAnimation {
                    showFavoritesOnly.toggle()
                }
            }) {
                Image(systemName: showFavoritesOnly ? "heart.fill" : "line.3.horizontal.decrease.circle")
                    .font(.title2)
                    // Cambia de color si está activo para dar feedback visual
                    .foregroundColor(showFavoritesOnly ? .yellow : .white)
                    .padding(8)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            
            HStack {
                TextField("Busca tu comida favorita...", text: $searchText)
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

struct RecetarioView_Previews: PreviewProvider {
    static var previews: some View {
        RecetarioView()
            .modelContainer(for: UserProfile.self, inMemory: true)
    }
}
