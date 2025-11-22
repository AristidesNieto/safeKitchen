import SwiftUI

// (Los colores siguen igual que antes)
extension Color {
    static let titleBlue = Color(red: 15/255, green: 75/255, blue: 155/255)
    static let buttonBlue = Color(red: 10/255, green: 70/255, blue: 150/255)
    static let textGray = Color(red: 60/255, green: 60/255, blue: 60/255)
    static let backgroundGray = Color(red: 235/255, green: 235/255, blue: 237/255)
    static let instructionBoxGray = Color(red: 225/255, green: 225/255, blue: 230/255)
    static let instructionShadowBlue = Color(red: 100/255, green: 120/255, blue: 180/255)
}

struct OnboardingInfoView: View {
    @State private var navigateToAlergia = false

    var body: some View {
        ZStack {
            // Fondo general de la pantalla
            Color.backgroundGray.edgesIgnoringSafeArea(.all)
            
            // VStack principal que contiene TODO
            VStack {
                
                // --- NUEVA ESTRUCTURA ZSTACK PARA LA PARTE SUPERIOR ---
                // Usamos alignment: .top para que todo empiece desde arriba
                ZStack(alignment: .top) {
                    
                    // CAPA 1 (Al fondo): Textos y Caja de instrucciones
                    VStack(spacing: 25) {
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
                        
                        // Caja de instrucciones con sombra
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.instructionShadowBlue)
                                .offset(x: 10, y: 10)
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.instructionBoxGray)
                            
                            Text("Contesta el siguiente quiz\nde esta manera")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .frame(height: 100)
                        .padding(.horizontal, 20)
                        
                        // Un Spacer invisible aquí para asegurar que esta capa de fondo
                        // tenga altura suficiente si la imagen es muy alta.
                         Spacer()
                    }
                    // Es importante darle una altura máxima a esta zona para que la imagen
                    // no se coma toda la pantalla si es gigante.
                    // Ajusta este valor (p.ej. 450) según necesites.
                    .frame(maxHeight: 450)

                    
                    // CAPA 2 (Al frente): La Imagen Central
                    Image("imagen_instrucciones_swipe") // <--- PON EL NOMBRE DE TU IMAGEN
                        .resizable()
                        .scaledToFit()
                        //.padding(.horizontal, 0)
                        // EL TRUCO: Usamos padding superior para "bajar" la imagen.
                        // Así no tapa el título "Antes de empezar", pero sí se superpone
                        // a la caja de instrucciones. Juega con este valor (ej: 150, 180, 200).
                        .padding(.top, 300)
                }
                // --- FIN DEL ZSTACK SUPERIOR ---

                // El Spacer empuja el botón hacia abajo.
                // Al estar fuera del ZStack de arriba, la imagen nunca lo tapará.
                Spacer()
                
                // --- Botón Siguiente (Seguro en el fondo) ---
                Button(action: {
                    print("Navegar a alergia.swift")
                    navigateToAlergia = true
                }) {
                    Text("SIGUIENTE")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        //.frame(maxWidth: .infinity)
                        .frame(minWidth: 130)
                        .padding()
                        .background(Color.buttonBlue)
                        .cornerRadius(25)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
            .navigationDestination(isPresented: $navigateToAlergia) {
                        // Pon aquí el nombre EXACTO que viste en el paso 1
                        alergia()
                            .navigationBarBackButtonHidden(true) // Opcional: oculta el botón "Atrás" por defecto
            }
        }
    }
}

struct OnboardingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingInfoView()
    }
}
