//
//  alergia.swift
//  safeKitchen
//
//  Created by Administrador on 21/09/25.
//

// alergia.swift
import SwiftUI

struct alergia: View {
    var body: some View {
        ZStack {
            // Fondo degradado
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                // MARK: - Header (Barra Superior)
                HStack {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    // Logo o título central
                    Image("cmica_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "info.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding()

                // Título del Cuestionario
                Text("Cuestionario")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                // MARK: - Tarjetas de Preguntas (Superpuestas)
                ZStack {
                    QuestionCardView(questionText: "This is a question behind the current one.")
                        .offset(y: 10)
                        .scaleEffect(0.95)
                        .opacity(0.7)

                    QuestionCardView(questionText: "Do you have more than one source of income?")
                }
                .padding(.top, 20)

                Spacer()

                // MARK: - Botones de Reacción
                HStack(spacing: 40) {
                    Button(action: {}) {
                        Image(systemName: "hand.thumbsdown.fill")
                            .font(.largeTitle)
                            .padding(20)
                            .background(Color.white)
                            .clipShape(Circle())
                            .foregroundColor(.red)
                            .shadow(radius: 5)
                    }

                    Button(action: {}) {
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.largeTitle)
                            .padding(20)
                            .background(Color.white)
                            .clipShape(Circle())
                            .foregroundColor(.green)
                            .shadow(radius: 5)
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}
struct alergia_Previews: PreviewProvider {
    static var previews: some View {
        alergia() // <-- Asegúrate de que aquí llame a "alergia()"
    }
}
