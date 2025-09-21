//
//  HomeView.swift
//  safeKitchen
//
//  Created by Luis Angel Zempoalteca on 20/09/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                
                HStack {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                }
                .padding()
                .padding(.vertical, 30)
                .background(Color.blue)
                
                // Seccion 1

                
                VStack(alignment: .leading, spacing: 8) {
                    Text("¿No sabes que comer? Aqui tienes un recetario")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    HStack(spacing: 15) {
                        Image("recetario")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170, height: 70)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Recetario")
                                .font(.subheadline)
                                .bold()
                            
                            Text("Encuentra ideas libres de ese alimento")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }



                // Seccion 2
                VStack(alignment: .leading, spacing: 10) {
                    Text("¿Te sientes mal? Toma este quiz")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    HStack(spacing: 15) {
                        Image("sintomas")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170, height: 70)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Síntomas")
                                .font(.subheadline)
                                .bold()
                            Text("Descubre que enfermedad tienes")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                // Seccion 3
                VStack(alignment: .leading, spacing: 10) {
                    Text("Cuestionario inicial:")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    HStack(spacing: 15) {
                        Image("cuestionario")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170, height: 70)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Cuestionario de información previa")
                                .font(.subheadline)
                                .bold()
                            Text("Realiza este cuestionario para personalizar tus recomendaciones")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                // Sección 4
                VStack(alignment: .leading, spacing: 10) {
                    Text("Tutorial Esencial")
                        .font(.headline)
                    HStack {
                        Image("imagen5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 80)
                            .cornerRadius(10)
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 80, height: 80)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .ignoresSafeArea(edges: .top)

    }
}

#Preview {
    ContentView()
}
