//
//  RecetarioView.swift
//  safeKitchen
//
//  Created by Aristides Nieto Guzman on 12/11/25.
//

import SwiftUI

// --- VISTA CONTENEDORA: Junta todos los componentes ---
struct RecetarioView: View {
    // El @State ahora maneja la lista que viene de nuestra fuente de datos
    @State private var recipes = recipeList
    @State private var searchText: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // 1. El header azul
            RecetarioHeaderView()
            
            // 2. La barra de búsqueda
            SearchBarView(searchText: $searchText)
            
            // 3. La lista de tarjetas
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Aquí es donde se usa el ForEach para mostrar la lista
                    ForEach($recipes) { $recipe in
                        RecipeListItemView(recipe: $recipe)
                    }
                }
                .padding()
            }
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea(edges: .top)
    }
}

// --- Componentes que pertenecen solo a esta pantalla ---

struct RecetarioHeaderView: View {
    var body: some View {
        HStack {
            Button(action: {
                // Lógica para volver a la pantalla anterior
            }) {
                Image(systemName: "chevron.left")
            }
            
            Spacer()
            
            Button(action: {
                // Lógica para abrir el menú lateral
            }) {
                Image(systemName: "line.3.horizontal")
            }
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundColor(.white)
        .padding()
        .padding(.top, 40) // Espacio para la barra de estado
        .background(Color.blue)
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 10) {
            Button(action: {
                // Lógica para filtrar
            }) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            
            HStack {
                TextField("Search your favorite food....", text: $searchText)
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
        }
        .padding()
        .background(Color(.systemGray6)) // Fondo igual al de la lista
    }
}


// --- PREVISUALIZACIÓN PARA CANVAS DE SWIFTUI ---
struct RecetarioView_Previews: PreviewProvider {
    static var previews: some View {
        // Ahora el preview de ESTE archivo SÍ te mostrará la lista completa
        RecetarioView()
    }
}
