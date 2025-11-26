//
//  HomeView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//
import SwiftUI
import SwiftData

// --- VISTA CONTENEDORA PRINCIPAL ---
struct MainView: View {
    @State private var isSideMenuShowing = false
    
    var body: some View {
        NavigationStack {
            let screenWidth = UIScreen.main.bounds.width
            ZStack {
                HomeView(isSideMenuShowing: $isSideMenuShowing)
                if isSideMenuShowing {
                    Color.black.opacity(0.4).ignoresSafeArea().onTapGesture { withAnimation(.spring()) { isSideMenuShowing = false } }.transition(.opacity)
                }
                HStack {
                    Spacer()
                    SideMenuView(isShowing: $isSideMenuShowing).frame(width: screenWidth * 0.75)
                }.offset(x: isSideMenuShowing ? 0 : screenWidth).animation(.spring(response: 0.4, dampingFraction: 0.8), value: isSideMenuShowing)
            }.navigationBarHidden(true)
        }
    }
}

// --- VISTA PRINCIPAL CON EL CONTENIDO ---
struct HomeView: View {
    @Binding var isSideMenuShowing: Bool
    @Query var users: [UserProfile]
    
    // MODIFICACIÓN: Ya no usamos una lista fija de 3 recetas.
    // Usamos la lista global 'recipeList' que viene de RecipeDataSource.swift
    
    var safeRecommendations: [CookbookRecipe] {
        guard let currentUser = users.first else {
            // Si no hay usuario, mostramos las primeras 3 por defecto
            return Array(recipeList.prefix(3))
        }
        
        // 1. Filtramos TODAS las recetas del sistema usando tu lógica 'isSafe'
        let allSafeRecipes = recipeList.filter { $0.isSafe(for: currentUser) }
        
        // 2. Devolvemos las primeras 5 para el carrusel (o todas si hay menos de 5)
        // Esto asegura que siempre haya opciones si existen en el recetario.
        return Array(allSafeRecipes.prefix(5))
    }
    
    @State private var currentRecommendationID: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(isSideMenuShowing: $isSideMenuShowing)
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Text("Hola \(users.first?.name ?? "Chef")").font(.largeTitle).fontWeight(.bold).foregroundColor(.blue)
                    VStack(alignment: .leading, spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Recomendaciones").font(.title2).fontWeight(.semibold)
                            Text("Platillos seguros para ti").font(.subheadline).foregroundColor(.gray)
                        }
                        
                        if safeRecommendations.isEmpty {
                            Text("No hay recomendaciones seguras disponibles.").foregroundColor(.gray).padding()
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(safeRecommendations) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: .constant(recipe))) {
                                            RecipeCard(recipe: recipe)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .id(recipe.id)
                                    }
                                }.scrollTargetLayout()
                            }
                            .scrollTargetBehavior(.viewAligned).safeAreaPadding(.horizontal, 40).frame(height: 180).scrollPosition(id: $currentRecommendationID)
                            
                            // Indicadores de página (puntos)
                            HStack(spacing: 8) {
                                ForEach(safeRecommendations) { recipe in
                                    Circle().fill(recipe.id == currentRecommendationID ? Color.blue : Color.gray.opacity(0.5)).frame(width: 8, height: 8).animation(.spring(), value: currentRecommendationID)
                                }
                            }.frame(maxWidth: .infinity).onAppear { currentRecommendationID = safeRecommendations.first?.id }
                        }
                    }
                    
                    // --- SECCIÓN DE BOTONES ---
                    ActionsMenuView()
                    
                    NavigationLink(destination: RecetarioView().navigationBarBackButtonHidden(true)) {
                        RecetarioBannerView()
                    }.buttonStyle(.plain)
                }.padding(.horizontal, 20).padding(.top, 20)
            }
        }.background(Color(.systemGroupedBackground)).ignoresSafeArea(edges: .top)
    }
}

// --- MENÚ DE ACCIONES CON NAVEGACIÓN ---
struct ActionsMenuView: View {
    var body: some View {
        HStack {
            Spacer()
            
            // Botón 1: Favoritas
            NavigationLink(destination: RecetarioView(filterFavorites: true).navigationBarBackButtonHidden(true)) {
                ActionMenuItem(icon: "heart.fill", text: "Favoritas")
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            // Botón 2: Personales
            NavigationLink(destination: RecetarioView(filterPersonal: true).navigationBarBackButtonHidden(true)) {
                ActionMenuItem(icon: "person.fill", text: "Personales")
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            // Botones Info
            ActionMenuItem(icon: "info.circle.fill", text: "Info")
            Spacer()

        }
    }
}

struct ActionMenuItem: View {
    var icon: String
    var text: String
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon).font(.title2)
            Text(text).font(.caption).fontWeight(.semibold)
        }
        .frame(width: 70, height: 55).padding(5).background(Color.blue).foregroundColor(.white).cornerRadius(15)
    }
}

// --- COMPONENTES AUXILIARES ---
struct SideMenuView: View {
    @Binding var isShowing: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                HStack { Spacer(); Text("Menu").font(.title2).fontWeight(.bold).foregroundColor(.white); Spacer() }.padding(.vertical).padding(.top, 40).background(Color.blue)
                VStack(alignment: .leading, spacing: 25) {
                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) { SideMenuItem(icon: "gear", text: "Configuración") }.buttonStyle(.plain)
                    NavigationLink(destination: MedicDataView().navigationBarBackButtonHidden(true)) { SideMenuItem(icon: "heart.text.square", text: "Datos Médicos") }.buttonStyle(.plain)
                }.padding()
                Spacer()
            }
        }.frame(maxWidth: .infinity, alignment: .leading).shadow(color: .black.opacity(0.2), radius: 5)
    }
}

struct SideMenuItem: View { var icon: String; var text: String; var body: some View { HStack(spacing: 15) { Image(systemName: icon).font(.headline).foregroundColor(.gray); Text(text).font(.headline).foregroundColor(.black) } } }

struct HeaderView: View { @Binding var isSideMenuShowing: Bool; var body: some View { HStack { Image("Logo").resizable().scaledToFit().frame(height: 60).cornerRadius(20); Spacer(); Button(action: { withAnimation(.spring()) { isSideMenuShowing.toggle() } }) { Image(systemName: "line.3.horizontal").font(.title).foregroundColor(.white) } }.padding(.horizontal).padding(.top, 40).padding(.bottom, 10).background(Color.blue) } }

struct RecipeCard: View { let recipe: CookbookRecipe; var body: some View { ZStack(alignment: .bottomLeading) { recipe.getImage().resizable().aspectRatio(contentMode: .fill).frame(width: 280, height: 180).background(Color.gray.opacity(0.2)).clipped(); LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.7)]), startPoint: .center, endPoint: .bottom); Text(recipe.title).font(.headline).fontWeight(.bold).foregroundColor(.white).padding() }.frame(width: 280, height: 180).cornerRadius(15).shadow(radius: 5) } }

struct RecetarioBannerView: View { var body: some View { ZStack(alignment: .bottomLeading) { Image("rece").resizable().aspectRatio(contentMode: .fill).frame(height: 200).background(Color.gray.opacity(0.2)).clipped(); LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(1.0)]), startPoint: .center, endPoint: .bottom); VStack(alignment: .leading, spacing: 4) { Text("Recetario").font(.title).fontWeight(.bold); Text("Descubre una variedad de platillos para tu día a día").font(.subheadline) }.foregroundColor(.white).padding() }.frame(height: 200).cornerRadius(15).clipped().shadow(radius: 5) } }

struct HomeView_Previews: PreviewProvider { static var previews: some View { MainView().modelContainer(for: [UserProfile.self, UserRecipe.self], inMemory: true) } }
