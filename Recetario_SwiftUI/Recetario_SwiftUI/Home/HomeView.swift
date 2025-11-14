//
//  HomeView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//
import SwiftUI

// --- VISTA CONTENEDORA PRINCIPAL ---

struct MainView: View {
    @State private var isSideMenuShowing = false
    
    var body: some View {
        NavigationStack {
            let screenWidth = UIScreen.main.bounds.width
            
            ZStack {
                HomeView(isSideMenuShowing: $isSideMenuShowing)
                
                if isSideMenuShowing {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isSideMenuShowing = false
                            }
                        }
                        .transition(.opacity)
                }
                
                HStack {
                    Spacer()
                    SideMenuView(isShowing: $isSideMenuShowing)
                        .frame(width: screenWidth * 0.75)
                }
                .offset(x: isSideMenuShowing ? 0 : screenWidth)
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isSideMenuShowing)
            }
            .navigationBarHidden(true)
        }
    }
}


// --- VISTA PRINCIPAL CON EL CONTENIDO ---
struct HomeView: View {
    @Binding var isSideMenuShowing: Bool
    
    // --- CAMBIO: Ahora usamos nuestro modelo 'CookbookRecipe' ---
    // Proveemos datos "dummy" para los campos que esta vista no usa
    // (como 'ingredients' y 'isFavorite').
    let recommendations = [
        CookbookRecipe(title: "Wrap de Atún", imageName: "receta3", ingredients: [], isFavorite: false),
        CookbookRecipe(title: "Beef & Broccoli", imageName: "receta2", ingredients: [], isFavorite: false),
        CookbookRecipe(title: "Hot-cakes de avena", imageName: "receta1", ingredients: [], isFavorite: false)
    ]
    
    @State private var currentRecommendationID: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(isSideMenuShowing: $isSideMenuShowing)

            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Text("Hola Beto")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading, spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Recomendaciones")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Platillos que creemos te encantarán")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(recommendations) { recipe in
                                    RecipeCard(title: recipe.title, imageName: recipe.imageName)
                                        .id(recipe.id)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .safeAreaPadding(.horizontal, 40)
                        .frame(height: 180)
                        .scrollPosition(id: $currentRecommendationID)
                        
                        HStack(spacing: 8) {
                            ForEach(recommendations) { recipe in
                                Circle()
                                    .fill(recipe.id == currentRecommendationID ? Color.blue : Color.gray.opacity(0.5))
                                    .frame(width: 8, height: 8)
                                    .animation(.spring(), value: currentRecommendationID)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .onAppear {
                            currentRecommendationID = recommendations.first?.id
                        }
                    }

                    ActionsMenuView()

                    NavigationLink(destination: RecetarioView()) {
                        RecetarioBannerView()
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
        }
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .top)
    }
}

// --- COMPONENTE PARA EL MENÚ LATERAL ---
struct SideMenuView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Text("Menu")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical)
                .padding(.top, 40)
                .background(Color.blue)

                VStack(alignment: .leading, spacing: 25) {
                    SideMenuItem(icon: "gear", text: "Configuración")
                    SideMenuItem(icon: "heart.text.square", text: "Datos Médicos")
                }
                .padding()
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .shadow(color: .black.opacity(0.2), radius: 5)
    }
}

// --- COMPONENTE PARA CADA ITEM DEL MENÚ LATERAL ---
struct SideMenuItem: View {
    var icon: String
    var text: String
    
    var body: some View {
        Button(action: {
            print("Tapped on \(text)")
        }) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(.gray)
                Text(text)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
    }
}


// --- COMPONENTE PARA EL HEADER ---
struct HeaderView: View {
    @Binding var isSideMenuShowing: Bool
    
    var body: some View {
        HStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .cornerRadius(20)

            
            Spacer()
            
            Button(action: {
                withAnimation(.spring()) {
                    isSideMenuShowing.toggle()
                }
            }) {
                Image(systemName: "line.3.horizontal")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
        .padding(.top, 40)
        .padding(.bottom, 10)
        .background(Color.blue)
    }
}


// --- COMPONENTE PARA LAS TARJETAS DE RECETAS ---
struct RecipeCard: View {
    var title: String
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.gray.opacity(0.2))

            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                startPoint: .center,
                endPoint: .bottom
            )
            
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
        }
        .cornerRadius(15)
        .clipped()
        .shadow(radius: 5)
    }
}

// --- COMPONENTE PARA EL BANNER DE RECETARIO ---
struct RecetarioBannerView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("recetariopreview")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .background(Color.gray.opacity(0.2))

            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                startPoint: .center,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Recetario")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Descubre una variedad de platillos para tu día a día")
                    .font(.subheadline)
            }
            .foregroundColor(.white)
            .padding()
        }
        .frame(height: 200)
        .cornerRadius(15)
        .clipped()
        .shadow(radius: 5)
    }
}


// --- COMPONENTE PARA EL MENÚ DE ACCIONES ---
struct ActionsMenuView: View {
    var body: some View {
        HStack {
            Spacer()
            ActionMenuItem(icon: "heart.fill", text: "Favoritas")
            Spacer()
            ActionMenuItem(icon: "person.fill", text: "Personales")
            Spacer()
            ActionMenuItem(icon: "info.circle.fill", text: "Info")
            Spacer()
            ActionMenuItem(icon: "camera.fill", text: "Cámara")
            Spacer()
        }
    }
}

// --- COMPONENTE PARA CADA ITEM DEL MENÚ ---
struct ActionMenuItem: View {
    var icon: String
    var text: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .font(.title2)
            
            Text(text)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .frame(width: 70, height: 55)
        .padding(5)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(15)
    }
}

// --- PREVISUALIZACIÓN PARA CANVAS DE SWIFTUI ---
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
