//
//  QuestionCardView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
// este  como  que no

import SwiftUI

struct QuestionCardView: View {
    let questionText: String
    let index: Int
    let totalQuestions: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // MARK: - Barra de Progreso
            // Calculamos el ancho de la barra azul basado en el índice
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Fondo de la barra (color beige/crema)
                    Capsule()
                        .fill(Color.orange.opacity(0.2))
                        .frame(height: 8)
                    
                    // Progreso (color azul)
                    Capsule()
                        .fill(Color.blue)
                        .frame(width: geometry.size.width * (CGFloat(index) / CGFloat(totalQuestions)), height: 8)
                }
            }
            .frame(height: 8)
            .padding(.top, 10)
            
            // MARK: - Texto "Pregunta X de Y"
            Text("Pregunta \(index) de \(totalQuestions)")
                .font(.subheadline)
                .foregroundColor(.blue)
                .fontWeight(.medium)
                .padding(.top, 40)

            // MARK: - Pregunta Principal
            Text(questionText)
                .font(.system(size: 28, weight: .bold)) // Fuente grande y negrita
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .padding(25)
        .frame(maxWidth: .infinity, maxHeight: 450) // Altura fija para que las cartas sean iguales
        //.background(Color.white)
        //.foregroundColor(.white)
        .background(
            RadialGradient(
                gradient: Gradient(colors: [.white, .blue]),
                center: .top,
                startRadius: 270,
                endRadius: 700
            )
        )
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            QuestionCardView(questionText: "Eres alergico al camaron?", index: 1, totalQuestions: 4)
                .padding()
        }
    }
}
