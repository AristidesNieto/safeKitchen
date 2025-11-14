//
//  MedicDataView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI

struct MedicDataView: View {
    // @State private var modoOscuroClaro = false // Ya no se usa
    
    // --- NUEVO: Añadimos @State para los datos ---
    @State private var edad: String = "18"
    @State private var sexo: String = "H"
    @State private var altura: String = "178cm"

    var body: some View {
        
        // --- NECESARIO: Para que los NavigationLink (flechas) funcionen ---
        NavigationStack {
            VStack(spacing: 0) {
          
                // --- ENCABEZADO (Idéntico al tuyo, sin cambios) ---
                ZStack {
                    Color.blue
                        .ignoresSafeArea(edges: .top)
                    HStack {
                        Button(action: {
                            // Tu acción de "ir atrás"
                        }) {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }

                        Spacer()

                        Text("Datos Medicos")
                            .font(.title)
                            .foregroundColor(.white)

                        Spacer()

                        Image(systemName: "chevron.backward")
                            .opacity(0)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 56)
                
                // --- LISTA (Modificada para tu nueva imagen) ---
                List {
                    // Sección Ajustes
                    Section(header: Text("Info basica").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                        
                        // Fila 1: Edad
                        NavigationLink(destination: Text("Pantalla para editar Edad")) {
                            HStack {
                                Text("Edad")
                                Spacer()
                                Text(edad)
                                    .foregroundColor(.secondary)
                            }
                        }

                        // Fila 2: Sexo Biologico
                        NavigationLink(destination: Text("Pantalla para editar Sexo")) {
                            HStack {
                                Text("Sexo Biologico")
                                Spacer()
                                Text(sexo)
                                    .foregroundColor(.secondary)
                            }
                        }

                        // Fila 3: Altura
                        NavigationLink(destination: Text("Pantalla para editar Altura")) {
                            HStack {
                                Text("Altura")
                                Spacer()
                                Text(altura)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle()) // <-- Mantenemos tu estilo
                .scrollContentBackground(.hidden) // Para que el fondo de la lista sea gris
                .background(Color(.systemGray6)) // Fondo gris
            }
            .background(Color(.systemGray6)) // Fondo gris para toda la vista
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct MedicDataView_Previews: PreviewProvider {
    static var previews: some View {
        MedicDataView()
    }
}
