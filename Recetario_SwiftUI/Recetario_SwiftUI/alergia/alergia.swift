//
//  alergia.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI

struct alergia: View {
    // Datos dummy para visualizar las 4 preguntas
    @State var questions = [
        "¿Tienes alguna alergia a los lácteos?",
        "¿Eres alérgico al gluten?",
        "¿Tienes problemas con las nueces?",
        "¿Eres alérgico al camarón?" // Esta será la última en el array, pero visualmente la primera (por el ZStack)
    ]
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            // 1. Fondo Azul Sólido (Ajustado al tono de tu imagen)
            Color(red: 0.15, green: 0.30, blue: 0.75) // Un azul rey similar al screenshot
                .edgesIgnoringSafeArea(.all)

            VStack {
                // MARK: - Header Simple
                HStack {
                    Button(action: {
                        // Acción para regresar
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "chevron.left")
                            Text("Pregunta anterior")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 100)
                
                Spacer()

                // MARK: - Stack de Cartas (ZStack)
                ZStack {
                    // Iteramos sobre las preguntas.
                    // Usamos reversed() para que la última del array quede hasta arriba visualmente
                    // Ojo: Para un sistema real usaremos índices, aquí es visual.
                    ForEach(0..<questions.count, id: \.self) { index in
                        
                        // Lógica visual para apilar las cartas
                        // Si es la última carta (la de hasta arriba), es la activa
                        let isTopCard = index == questions.count - 1
                        
                        QuestionCardView(
                            questionText: questions[index],
                            index: index + 1,
                            totalQuestions: questions.count
                        )
                        // Ajustes visuales para el efecto "Pila"
                        .scaleEffect(isTopCard ? 1 : 0.9 - CGFloat(questions.count - index) * 0.05)
                        .offset(y: isTopCard ? 0 : CGFloat(questions.count - index) * 15)
                        .opacity(isTopCard ? 1 : 0.5) // Las de atrás se ven un poco transparentes u oscuras
                        
                        // Lógica de Movimiento (Solo a la carta superior)
                        .offset(x: isTopCard ? offset.width : 0, y: isTopCard ? offset.height : 0)
                        .rotationEffect(.degrees(isTopCard ? Double(offset.width / 10) : 0))
                        .gesture(
                            isTopCard ?
                            DragGesture()
                                .onChanged { gesture in
                                    self.offset = gesture.translation
                                }
                                .onEnded { _ in
                                    // Aquí iría la lógica para descartar (backend)
                                    // Por ahora regresa al centro para probar el diseño
                                    withAnimation(.spring()) {
                                        self.offset = .zero
                                    }
                                }
                            : nil // Las cartas de atrás no tienen gesto
                        )
                    }
                }
                .padding(.horizontal, 20)
                .offset(y: -80) // Subir un poco todo el stack para centrarlo

                Spacer()
            }
        }
    }
}

struct alergia_Previews: PreviewProvider {
    static var previews: some View {
        alergia()
    }
}
