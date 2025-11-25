//
//  ProfileView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    // --- CONEXIÓN GLOBAL: Estas variables guardan la configuración en el teléfono ---
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("userLanguage") private var userLanguage = "es"
    
    // Eliminado: @State private var nombre
    
    @State private var showLanguageSheet = false

    // Texto dinámico para mostrar el idioma actual
    var idiomaTexto: String {
        return userLanguage == "es" ? "Español" : "English"
    }

    var body: some View {
        VStack(spacing: 0) {
            
            // HEADER AZUL
            ZStack {
                Color.blue.ignoresSafeArea(edges: .top)
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                    Spacer()
                    Text("Configuración")
                        .font(.title)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.backward").opacity(0)
                }
                .padding(.horizontal)
            }
            .frame(height: 56)
            
            // LISTA DE OPCIONES
            List {
                Section(header: Text("Ajustes").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                    // INTERRUPTOR DE MODO OSCURO
                    HStack {
                        Image(systemName: "gearshape.fill")
                        Text("Modo Oscuro")
                        Spacer()
                        // Al mover esto, @AppStorage actualiza toda la app automáticamente
                        Toggle("", isOn: $isDarkMode)
                            .labelsHidden()
                            .tint(.blue)
                    }

                    // SELECTOR DE IDIOMA
                    Button(action: {
                        showLanguageSheet = true
                    }) {
                        HStack {
                            Image(systemName: "character.book.closed.fill")
                                .foregroundColor(.primary)
                            Text("Idioma")
                                .foregroundColor(.primary)
                            Spacer()
                            Text(idiomaTexto)
                                .foregroundColor(.secondary)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // Se eliminó la Section("Información") con el botón de Nombre
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarBackButtonHidden(true)
        
        // HOJAS DE EDICIÓN (SHEETS)
        // Se eliminó: .sheet(isPresented: $showNameSheet)
        
        .sheet(isPresented: $showLanguageSheet) {
            EditLanguageView(isPresented: $showLanguageSheet, currentLanguage: $userLanguage)
                .presentationDetents([.height(350)])
                .presentationCornerRadius(30)
                .presentationDragIndicator(.hidden)
        }
    }
}

// --- VISTAS AUXILIARES ---

struct EditLanguageView: View {
    @Binding var isPresented: Bool
    @Binding var currentLanguage: String
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Text("Selecciona Idioma").font(.headline).fontWeight(.bold)
                HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } }
            }
            .padding(.top, 20)
            
            Button(action: { currentLanguage = "es"; isPresented = false }) {
                languageRow(text: "Español", isSelected: currentLanguage == "es")
            }
            
            Button(action: { currentLanguage = "en"; isPresented = false }) {
                languageRow(text: "English", isSelected: currentLanguage == "en")
            }
            Spacer()
        }
        .padding(25)
    }
    
    func languageRow(text: String, isSelected: Bool) -> some View {
        HStack {
            Text(text).font(.system(size: 18, weight: .medium)).foregroundColor(.primary)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark.circle.fill").foregroundColor(.blue).font(.title2)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// Se eliminó struct EditNameView (ahora vive en MedicDataView)

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
