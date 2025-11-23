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
    
    // Accedemos a SwiftData para filtrar recomendaciones seguras
    @Query var users: [UserProfile]
    
    // Definimos las recomendaciones
    let recommendations = [
        CookbookRecipe(
            title: "Wrap de Atún",
            imageName: "receta3",
            ingredients: ["Atún", "Pan pita", "Cebolla", "Aguacate"],
            instructions: "Mezcla el atún y rellena el pan pita.",
            containsAllergens: [.fish, .gluten],
            isFavorite: false
        ),
        CookbookRecipe(
            title: "Beef & Broccoli",
            imageName: "receta2",
            ingredients: ["Carne de Res", "Broccoli", "Soya"],
            instructions: "Saltea la carne y el brócoli con soya.",
            containsAllergens: [.soy],
            isFavorite: false
        ),
        CookbookRecipe(
            title: "Hot-cakes de avena",
            imageName: "receta1",
            ingredients: ["Avena", "Huevo", "Leche"],
            instructions: "Licúa y cocina en sartén.",
            containsAllergens: [.gluten, .eggs, .dairy],
            isFavorite: false
        )
    ]
    
    // Filtramos las recomendaciones según el usuario
    var safeRecommendations: [CookbookRecipe] {
        guard let currentUser = users.first else { return recommendations }
        return recommendations.filter { $0.isSafe(for: currentUser) }
    }
    
    @State private var currentRecommendationID: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(isSideMenuShowing: $isSideMenuShowing)

            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    // Saludo personalizado
                    Text("Hola \(users.first?.name ?? "Chef")")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading, spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Recomendaciones")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Platillos seguros para ti")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        // Carrusel de Recomendaciones
                        if safeRecommendations.isEmpty {
                            Text("No hay recomendaciones seguras disponibles.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(safeRecommendations) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: .constant(recipe))) {
                                            // AQUÍ ESTABA EL ERROR: Ahora pasamos la receta completa
                                            RecipeCard(recipe: recipe)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .id(recipe.id)
                                    }
                                }
                                .scrollTargetLayout()
                            }
                            .scrollTargetBehavior(.viewAligned)
                            .safeAreaPadding(.horizontal, 40)
                            .frame(height: 180)
                            .scrollPosition(id: $currentRecommendationID)
                            
                            // Indicadores de página (puntitos)
                            HStack(spacing: 8) {
                                ForEach(safeRecommendations) { recipe in
                                    Circle()
                                        .fill(recipe.id == currentRecommendationID ? Color.blue : Color.gray.opacity(0.5))
                                        .frame(width: 8, height: 8)
                                        .animation(.spring(), value: currentRecommendationID)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .onAppear {
                                currentRecommendationID = safeRecommendations.first?.id
                            }
                        }
                    }

                    ActionsMenuView()

                    NavigationLink(destination: RecetarioView().navigationBarBackButtonHidden(true)) {
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
                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
                        SideMenuItem(icon: "gear", text: "Configuración")
                    }
                    .buttonStyle(.plain)
                    
                    NavigationLink(destination: MedicDataView().navigationBarBackButtonHidden(true)) {
                        SideMenuItem(icon: "heart.text.square", text: "Datos Médicos")
                    }
                    .buttonStyle(.plain)
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


// --- COMPONENTE PARA LAS TARJETAS DE RECETAS (CORREGIDO) ---
struct RecipeCard: View {
    // CAMBIO: Ahora recibimos la receta completa en lugar de Strings sueltos
    let recipe: CookbookRecipe
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // CAMBIO: Usamos la función inteligente del modelo
            recipe.getImage()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 280, height: 180)
                .background(Color.gray.opacity(0.2))
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                startPoint: .center,
                endPoint: .bottom
            )
            
            Text(recipe.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: 280, height: 180)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

// --- COMPONENTE PARA EL BANNER DE RECETARIO ---
struct RecetarioBannerView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("rece")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .background(Color.gray.opacity(0.2))
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(1.0)]),
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

// --- COMPONENTE PARA CADA ITEM DEL MENÚ DE ACCIONES ---
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .modelContainer(for: UserProfile.self, inMemory: true)
    }
}
