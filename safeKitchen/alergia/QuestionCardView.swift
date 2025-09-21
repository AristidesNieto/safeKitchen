//
//  QuestionCardView.swift
//  safeKitchen
//
//  Created by Administrador on 21/09/25.
//

import SwiftUI

struct QuestionCardView: View {
    let questionText: String
    // Puedes añadir más propiedades si cada tarjeta necesita más datos
    
    var body: some View {
        VStack(alignment: .leading) {
            // Indicador de pregunta (ej. "Question 1 of 10")
            Text("Question X of Y") // Puedes hacer esto dinámico si lo necesitas
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 5)

            // La pregunta principal
            Text(questionText)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black) // Asegura que el texto sea visible
                .multilineTextAlignment(.leading) // Alinea a la izquierda
        }
        .padding(25) // Espacio dentro de la tarjeta
        .frame(maxWidth: .infinity) // Ocupa todo el ancho posible
        .background(
            RoundedRectangle(cornerRadius: 25) // Forma redondeada
                .fill(Color.white) // Fondo blanco
                .shadow(radius: 5) // Sombra suave para dar profundidad
        )
        .padding(.horizontal, 20) // Espacio a los lados de la tarjeta principal
    }
}

// Puedes añadir un Preview aquí para ver tu tarjeta de forma aislada
struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(questionText: "Do you have more than one source of income?")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
