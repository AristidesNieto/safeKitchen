//
//  QuestionCardView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI

struct QuestionCardView: View {
    let questionText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Question X of Y")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 5)

            Text(questionText)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
        .padding(25)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .padding(.horizontal, 20)
    }
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(questionText: "Do you have more than one source of income?")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
