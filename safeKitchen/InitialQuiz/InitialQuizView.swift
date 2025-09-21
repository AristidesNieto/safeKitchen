//
//  InitialQuizView.swift
//  safeKitchen
//
//  Created by Administrador on 21/09/25.
//

import SwiftUI

struct InitialQuizView: View {
    var body: some View {
        ZStack {
            // MARK: - Background
            Color(red: 236/255, green: 240/255, blue: 241/255)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 25) {
                // MARK: - Top Bar with Back Button and Progress Bar
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }

                    // Progress Bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: geometry.size.width, height: 10)
                                .opacity(0.3)
                                .foregroundColor(.gray)

                            Rectangle()
                                .frame(width: geometry.size.width * 0.2, height: 10)
                                .foregroundColor(.blue)
                        }
                        .cornerRadius(5)
                    }
                    .frame(height: 10)
                }
                .padding(.horizontal, 25)
                .padding(.top, 25)

                // MARK: - Main Question and Input Field
                VStack(alignment: .leading, spacing: 20) {
                    Text("¿Sabes a que\neres alergico?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            .frame(height: 50)
                            .background(Color.white)
                        
                        Text("Ingresa tus respuestas...")
                            .foregroundColor(.gray)
                            .padding(.leading, 15)
                    }
                    .frame(maxWidth: .infinity)

                    Button(action: {}) {
                        Text("No tengo idea")
                            .font(.callout)
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray.opacity(0.3))
                            )
                    }
                }
                .padding(.horizontal, 45)
                
                Spacer()

                // MARK: - Decorative Images (Ajustadas)
                HStack(spacing: 0) {
                    Spacer()
                    Image("fork")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .rotationEffect(.degrees(180)) // <-- Rotación corregida
                    
                    Spacer()

                    Image("fork")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .rotationEffect(.degrees(-270)) // <-- Rotación corregida
                    Spacer()
                }
                .padding(.bottom, 50)
            }
        }
    }
}

struct InitialQuizView_Previews: PreviewProvider {
    static var previews: some View {
        InitialQuizView()
    }
}
