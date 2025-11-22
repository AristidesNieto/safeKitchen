import SwiftUI

// 1. Definimos los colores personalizados basados en la imagen para que se vea igual.
extension Color {
    static let titleBlue = Color(red: 15/255, green: 75/255, blue: 155/255)
    static let buttonBlue = Color(red: 10/255, green: 70/255, blue: 150/255)
    static let textGray = Color(red: 60/255, green: 60/255, blue: 60/255)
    static let backgroundGray = Color(red: 235/255, green: 235/255, blue: 237/255)
    static let instructionBoxGray = Color(red: 225/255, green: 225/255, blue: 230/255)
    static let instructionShadowBlue = Color(red: 100/255, green: 120/255, blue: 180/255)
}

struct OnboardingInfoView: View {
    // Esta variable controlará la navegación más adelante
    @State private var navigateToAlergia = false

    var body: some View {
        // Usamos un ZStack para poner el color de fondo general
        ZStack {
            Color.backgroundGray.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                // --- Sección Superior: Textos ---
                VStack(spacing: 10) {
                    Text("Antes de empezar")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.titleBlue)
                    
                    Text("necesitamos saber un\npoco de ti")
                        .font(.system(size: 18))
                        .foregroundColor(.textGray)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                // --- Sección Media: Caja de Instrucciones ---
                // Usamos ZStack para crear el efecto de sombra sólida
                ZStack {
                    // La "sombra" azul de fondo
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.instructionShadowBlue)
                        .offset(x: 5, y: 5) // La movemos un poco a la derecha y abajo
                    
                    // La caja gris principal encima
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.instructionBoxGray)
                    
                    // El texto dentro de la caja
                    Text("Contesta el siguiente quiz\nde esta manera")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .frame(height: 100) // Altura fija para la caja
                .padding(.horizontal, 20)
                
                // --- Sección Visual Central (Imagen) ---
                // RECOMENDACIÓN: Reemplaza este bloque con tu imagen real.
                // Por ahora, uso un placeholder si no tienes la imagen "imagen_instrucciones_swipe"
                if UIImage(named: "imagen_instrucciones_swipe") != nil {
                    Image("imagen_instrucciones_swipe")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300) // Ajusta la altura según tu imagen
                } else {
                    // Placeholder visual por si no tienes la imagen todavía
                    VStack {
                        HStack(spacing: 100) {
                            Text("No").font(.title).bold().foregroundColor(.red)
                            Text("Sí").font(.title).bold().foregroundColor(.green)
                        }
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.5))
                            .frame(height: 200)
                            .overlay(Text("Aquí va la imagen de las tarjetas y flechas").padding())
                    }
                    .padding()
                }

                Spacer()
                
                // --- Botón Siguiente ---
                Button(action: {
                    // Aquí activaremos la navegación más tarde
                    print("Navegar a alergia.swift")
                    navigateToAlergia = true
                }) {
                    Text("SIGUIENTE")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.buttonBlue)
                        .cornerRadius(25)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
        }
        // Preparación para la navegación (lo vemos a detalle después)
        // .navigationDestination(isPresented: $navigateToAlergia) {
        //      AlergiaView()
        // }
    }
}

// Vista previa para Xcode
struct OnboardingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingInfoView()
    }
}
