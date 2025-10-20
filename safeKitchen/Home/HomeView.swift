//
//  HomeView.swift
//  safeKitchen
//
//  Created by Luis Angel Zempoalteca on 20/09/25.
//
import SwiftUI
struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

// --- VISTA PRINCIPAL DEL MENÚ ---
struct HomeView: View {
    let recommendations = [
        Recipe(title: "Wrap de Atún", imageName: "receta3"),
        Recipe(title: "Beef & Broccoli", imageName: "receta2"),
        Recipe(title: "Hot-cakes de avena", imageName: "receta1")
    ]
    @State private var currentRecommendationIndex: Int = 0

    var body: some View {
            // Usamos una VStack principal para apilar el header y el contenido estático
            VStack(spacing: 0) {
                // --- HEADER PERSONALIZADO ---
                HeaderView()

                // Contenido principal de la vista, ya no está dentro de un ScrollView
                VStack(alignment: .leading, spacing: 25) { // Reducimos el espaciado general
                    
                    // --- SALUDO AL USUARIO ---
                    Text("Hola Beto")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    // --- SECCIÓN DE RECOMENDACIONES ---
                    VStack(alignment: .leading, spacing: 15) { // Espaciado entre título y carrusel
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Recomendaciones")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Platillos que creemos te encantarán")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        // --- CARRUSEL CON SCROLLVIEW Y PEEKING EFFECT ---
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(recommendations.indices, id: \.self) { index in
                                    RecipeCard(title: recommendations[index].title, imageName: recommendations[index].imageName)
                                        .id(index)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .safeAreaPadding(.horizontal, 40) // Padding para que se vean las tarjetas de los lados
                        .frame(height: 180) // Aumentamos la altura
                        //.scrollPosition(id: $currentRecommendationIndex)
                        
                        // --- INDICADOR DE PÁGINA PERSONALIZADO ---
                        HStack(spacing: 8) {
                            ForEach(recommendations.indices, id: \.self) { index in
                                Circle()
                                    .fill(index == currentRecommendationIndex ? Color.blue : Color.gray.opacity(0.5))
                                    .frame(width: 8, height: 8)
                                    .animation(.spring(), value: currentRecommendationIndex)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }

                    // --- MENÚ DE ACCIONES ---
                    ActionsMenuView()

                    // --- SECCIÓN DE RECETARIO ---
                    RecetarioBannerView()
                    
                    // Este Spacer empuja todo el contenido hacia arriba
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .ignoresSafeArea(edges: .top) // Hacemos que el header ignore el área segura superior
            .background(Color(.systemGroupedBackground)) // Fondo para toda la vista
        }
}

struct HeaderView: View {
    var body: some View {
        HStack {
                // Logo a la izquierda
                Image("Logo") // Aquí pondrás el nombre de tu imagen de logo
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50) // Ajusta la altura según el tamaño de tu logo
                    .cornerRadius(20)
                
                Spacer() // El spacer empuja los elementos a los extremos
                
                // Botón de menú a la derecha
                Button(action: {
                    // Lógica para mostrar el menú lateral
                    print("Menu button tapped")
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
            .padding(.top, 70) // Padding superior para el área segura
            .padding(.bottom, 10)
            .background(Color.blue)
    }
}
struct RecetarioBannerView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("recetariopreview")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 240)
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
        .frame(height: 250)
        .cornerRadius(15)
        .clipped()
        .shadow(radius: 5)
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
            // Eliminamos el padding horizontal de aquí para que la tarjeta ocupe el espacio definido por el ScrollView
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
        HomeView()
    }
}


