//
//  RecetarioView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI
import SwiftData

struct RecetarioView: View {
    @Query var users: [UserProfile]
    @Query var userRecipes: [UserRecipe]
    
    @State private var recipes = recipeList
    
    @State private var searchText: String = ""
    
    // Estados de los filtros
    @State private var showFavoritesOnly: Bool
    @State private var showPersonalOnly: Bool // Nuevo filtro
    
    @State private var showAddRecipeSheet: Bool = false

    // --- NUEVO: Inicializador para recibir filtros desde el Home ---
    init(filterFavorites: Bool = false, filterPersonal: Bool = false) {
        // Inicializamos los @State con los valores que nos mandan
        _showFavoritesOnly = State(initialValue: filterFavorites)
        _showPersonalOnly = State(initialValue: filterPersonal)
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                RecetarioHeaderView()
                
                // Pasamos el binding de favoritos
                SearchBarView(searchText: $searchText, showFavoritesOnly: $showFavoritesOnly)
                
                // Pequeña etiqueta visual si estamos filtrando personales
                if showPersonalOnly {
                    HStack {
                        Text("Mostrando tus recetas personales")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        Button(action: { showPersonalOnly = false }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 8)
                }
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if filteredRecipes.isEmpty {
                            ContentUnavailableView(
                                contentUnavailableTitle,
                                systemImage: contentUnavailableIcon,
                                description: Text(contentUnavailableDescription)
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
    }
    
    // --- Lógica de Filtrado Actualizada ---
    var filteredRecipes: [CookbookRecipe] {
        let currentUser = users.first ?? UserProfile()
        let convertedUserRecipes = userRecipes.map { $0.toCookbookRecipe() }
        let allRecipes = recipes + convertedUserRecipes
        
        return allRecipes.filter { recipe in
            let isSafe = recipe.isSafe(for: currentUser)
            let matchesSearch = searchText.isEmpty || recipe.title.localizedCaseInsensitiveContains(searchText)
            
            // Filtro de Favoritos
            let matchesFavorite = !showFavoritesOnly || recipe.isFavorite
            
            // Filtro de Personales (Sabemos que es personal si tiene imageData)
            let matchesPersonal = !showPersonalOnly || (recipe.imageData != nil)
            
            return isSafe && matchesSearch && matchesFavorite && matchesPersonal
        }
    }
    
    // Helpers para mensajes de estado vacío
    var contentUnavailableTitle: String {
        if showFavoritesOnly { return "Sin favoritos" }
        if showPersonalOnly { return "Sin recetas personales" }
        return "No encontrado"
    }
    
    var contentUnavailableIcon: String {
        if showFavoritesOnly { return "heart.slash" }
        if showPersonalOnly { return "person.crop.circle.badge.questionmark" }
        return "magnifyingglass"
    }
    
    var contentUnavailableDescription: String {
        if showFavoritesOnly { return "Marca recetas como favoritas para verlas aquí." }
        if showPersonalOnly { return "Usa el botón + para crear tu primera receta." }
        return "Intenta otra búsqueda."
    }
    
    func getBinding(for recipe: CookbookRecipe) -> Binding<CookbookRecipe> {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            return $recipes[index]
        }
        if let userRecipe = userRecipes.first(where: { $0.id == recipe.id }) {
            return Binding(
                get: { recipe },
                set: { newRecipe in
                    userRecipe.isFavorite = newRecipe.isFavorite
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
            Button(action: { withAnimation { showFavoritesOnly.toggle() } }) {
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
