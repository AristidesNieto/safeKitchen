//
//  RecetarioView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI
import SwiftData

struct RecetarioView: View {
    // 1. Necesitamos el contexto para guardar cambios
    @Environment(\.modelContext) var modelContext
    
    @Query var users: [UserProfile]
    @Query var userRecipes: [UserRecipe]
    
    @State private var recipes = recipeList
    
    @State private var searchText: String = ""
    
    // Estados de los filtros
    @State private var showFavoritesOnly: Bool
    @State private var showPersonalOnly: Bool
    
    @State private var showAddRecipeSheet: Bool = false

    // Inicializador para recibir filtros desde el Home
    init(filterFavorites: Bool = false, filterPersonal: Bool = false) {
        _showFavoritesOnly = State(initialValue: filterFavorites)
        _showPersonalOnly = State(initialValue: filterPersonal)
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                RecetarioHeaderView()
                
                // Pasamos ambos bindings al buscador
                SearchBarView(
                    searchText: $searchText,
                    showFavoritesOnly: $showFavoritesOnly,
                    showPersonalOnly: $showPersonalOnly
                )
                
                // Etiquetas visuales para saber qué filtro está activo
                if showFavoritesOnly || showPersonalOnly {
                    HStack(spacing: 10) {
                        if showFavoritesOnly {
                            FilterChip(title: "Favoritas", isActive: $showFavoritesOnly)
                        }
                        if showPersonalOnly {
                            FilterChip(title: "Personales", isActive: $showPersonalOnly)
                        }
                    }
                    .padding(.top, 8)
                }
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if filteredRecipes.isEmpty {
                            ContentUnavailableView(
                                "No encontrado",
                                systemImage: "magnifyingglass",
                                description: Text("No hay recetas con estos filtros.")
                            )
                            .padding(.top, 50)
                            .foregroundColor(.gray)
                        } else {
                            ForEach(filteredRecipes) { recipe in
                                let recipeBinding = getBinding(for: recipe)
                                NavigationLink(destination: RecipeDetailView(recipe: recipeBinding)) {
                                    RecipeListItemView(recipe: recipeBinding)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 80)
                }
            }
            
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
        // 2. Sincronizar favoritos al cargar la vista
        .onAppear {
            syncFavorites()
        }
    }
    
    // Sincroniza las recetas estáticas con la base de datos del usuario
    func syncFavorites() {
        guard let user = users.first else { return }
        
        for i in 0..<recipes.count {
            // Si el título está guardado en el perfil, marcamos como favorito
            if user.favoriteRecipeTitles.contains(recipes[i].title) {
                recipes[i].isFavorite = true
            } else {
                recipes[i].isFavorite = false
            }
        }
    }
    
    var filteredRecipes: [CookbookRecipe] {
        let currentUser = users.first ?? UserProfile()
        let convertedUserRecipes = userRecipes.map { $0.toCookbookRecipe() }
        let allRecipes = recipes + convertedUserRecipes
        
        return allRecipes.filter { recipe in
            let isSafe = recipe.isSafe(for: currentUser)
            let matchesSearch = searchText.isEmpty || recipe.title.localizedCaseInsensitiveContains(searchText)
            
            // Lógica de filtros (AND)
            let matchesFavorite = !showFavoritesOnly || recipe.isFavorite
            let matchesPersonal = !showPersonalOnly || (recipe.imageData != nil)
            
            return isSafe && matchesSearch && matchesFavorite && matchesPersonal
        }
    }
    
    func getBinding(for recipe: CookbookRecipe) -> Binding<CookbookRecipe> {
        // CASO 1: Receta personal (UserRecipe) guardada en SwiftData
        if let userRecipe = userRecipes.first(where: { $0.id == recipe.id }) {
            return Binding(
                get: { recipe },
                set: { newRecipe in
                    userRecipe.isFavorite = newRecipe.isFavorite
                    try? modelContext.save() // Guardar cambios inmediatos
                }
            )
        }
        
        // CASO 2: Receta estática del sistema
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            return Binding(
                get: { recipes[index] },
                set: { newRecipe in
                    // Actualizar estado visual
                    recipes[index] = newRecipe
                    
                    // Actualizar persistencia en UserProfile
                    if let user = users.first {
                        if newRecipe.isFavorite {
                            if !user.favoriteRecipeTitles.contains(newRecipe.title) {
                                user.favoriteRecipeTitles.append(newRecipe.title)
                            }
                        } else {
                            user.favoriteRecipeTitles.removeAll { $0 == newRecipe.title }
                        }
                        try? modelContext.save() // Guardar cambios inmediatos
                    }
                }
            )
        }
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

        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundColor(.white)
        .padding()
        .padding(.top, 40)
        .background(Color.blue)
    }
}

// VISTA DE CHIP PEQUEÑO PARA CERRAR FILTROS RÁPIDO
struct FilterChip: View {
    let title: String
    @Binding var isActive: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
            Image(systemName: "xmark.circle.fill")
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.blue.opacity(0.1))
        .foregroundColor(.blue)
        .cornerRadius(15)
        .onTapGesture {
            withAnimation { isActive = false }
        }
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var showFavoritesOnly: Bool
    @Binding var showPersonalOnly: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Menu {
                Toggle(isOn: $showFavoritesOnly) { Label("Favoritas", systemImage: "heart.fill") }
                Toggle(isOn: $showPersonalOnly) { Label("Personales", systemImage: "person.fill") }
            } label: {
                let isActive = showFavoritesOnly || showPersonalOnly
                Image(systemName: isActive ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                    .font(.title2)
                    .foregroundColor(isActive ? .yellow : .white)
                    .padding(8)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            
            HStack {
                TextField("Search your favorite food....", text: $searchText)
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
            }
            .padding(12)
            .background(Color(UIColor.secondarySystemGroupedBackground))
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
