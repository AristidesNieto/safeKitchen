//
//  RecetarioView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI
import SwiftData

struct RecetarioView: View {
    // 1. Usuario para alergias
    @Query var users: [UserProfile]
    
    // 2. Recetas creadas por el usuario (SwiftData)
    @Query var userRecipes: [UserRecipe]
    
    // 3. Recetas del sistema (Memoria local)
    @State private var recipes = recipeList
    
    @State private var searchText: String = ""
    @State private var showFavoritesOnly: Bool = false
    @State private var showAddRecipeSheet: Bool = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                // 1. Header
                RecetarioHeaderView()
                
                // 2. Barra de búsqueda
                SearchBarView(searchText: $searchText, showFavoritesOnly: $showFavoritesOnly)
                
                // 3. Lista de tarjetas
                ScrollView {
                    LazyVStack(spacing: 16) {
                        
                        if filteredRecipes.isEmpty {
                            ContentUnavailableView(
                                showFavoritesOnly ? "Sin favoritos" : "No se encontraron recetas",
                                systemImage: showFavoritesOnly ? "heart.slash" : "magnifyingglass",
                                description: Text("Intenta otra búsqueda o agrega una receta nueva.")
                            )
                            .padding(.top, 50)
                            .foregroundColor(.gray)
                        } else {
                            // Iteramos sobre la lista filtrada
                            ForEach(filteredRecipes) { recipe in
                                // OBTENEMOS EL BINDING REAL (DE ESCRITURA)
                                let recipeBinding = getBinding(for: recipe)
                                
                                NavigationLink(destination: RecipeDetailView(recipe: recipeBinding)) {
                                    RecipeListItemView(recipe: recipeBinding)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 80) // Espacio para el botón flotante
                }
            }
            
            // 4. Botón Flotante para Agregar Receta
            Button(action: {
                showAddRecipeSheet = true
            }) {
                Image(systemName: "plus")
                    .font(.title.weight(.bold))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
            }
            .padding()
            .padding(.bottom, 20)
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showAddRecipeSheet) {
            AddRecipeView()
        }
    }
    
    // --- LÓGICA MAESTRA: Combina y Filtra ---
    var filteredRecipes: [CookbookRecipe] {
        let currentUser = users.first ?? UserProfile()
        
        // 1. Convertimos las recetas de SwiftData al modelo visual
        let convertedUserRecipes = userRecipes.map { $0.toCookbookRecipe() }
        
        // 2. Unimos las listas
        let allRecipes = recipes + convertedUserRecipes
        
        // 3. Aplicamos filtros
        return allRecipes.filter { recipe in
            let isSafe = recipe.isSafe(for: currentUser)
            let matchesSearch = searchText.isEmpty || recipe.title.localizedCaseInsensitiveContains(searchText)
            let matchesFavorite = !showFavoritesOnly || recipe.isFavorite
            
            return isSafe && matchesSearch && matchesFavorite
        }
    }
    
    // --- SOLUCIÓN FAVORITOS: Binding Inteligente ---
    // Esta función decide dónde guardar el cambio (en @State o en SwiftData)
    func getBinding(for recipe: CookbookRecipe) -> Binding<CookbookRecipe> {
        
        // CASO A: Es una receta del sistema (@State)
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            return $recipes[index]
        }
        
        // CASO B: Es una receta de usuario (SwiftData)
        if let userRecipe = userRecipes.first(where: { $0.id == recipe.id }) {
            return Binding(
                get: { recipe },
                set: { newRecipe in
                    // Aquí actualizamos la base de datos real
                    userRecipe.isFavorite = newRecipe.isFavorite
                    // SwiftData guarda automáticamente el cambio
                }
            )
        }
        
        // Fallback (solo lectura, por si acaso)
        return .constant(recipe)
    }
}

// --- Componentes ---

struct RecetarioHeaderView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Button(action: { }) {
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
    @Binding var showFavoritesOnly: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Button(action: {
                withAnimation { showFavoritesOnly.toggle() }
            }) {
                Image(systemName: showFavoritesOnly ? "heart.fill" : "line.3.horizontal.decrease.circle")
                    .font(.title2)
                    .foregroundColor(showFavoritesOnly ? .yellow : .white)
                    .padding(8)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            
            HStack {
                TextField("Search your favorite food....", text: $searchText)
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
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
            .modelContainer(for: [UserProfile.self, UserRecipe.self], inMemory: true)
    }
}
