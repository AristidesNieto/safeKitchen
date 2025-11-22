//
//  ProfileView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI

struct ProfileView: View {
    // --- NUEVO: Variable para controlar el regreso (Dismiss) ---
    @Environment(\.dismiss) var dismiss
    
    @State private var modoOscuroClaro = false
    @State private var nombre: String = "Beto Perez"
    @State private var contraseña: String = "********"
    
    // --- NUEVO: Estado para el idioma ---
    @State private var idioma: String = "Español"
    
    // --- Estados para controlar los modales ---
    @State private var showNameSheet = false
    @State private var showLanguageSheet = false // <--- NUEVO

    var body: some View {
        VStack(spacing: 0) {
            
            // --- HEADER (INTACTO CON FUNCIONALIDAD AGREGADA) ---
            ZStack {
                Color.blue
                    .ignoresSafeArea(edges: .top)
                HStack {
                    Button(action: {
                        // --- CAMBIO: Acción para regresar ---
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }

                    Spacer()

                    Text("Perfil")
                        .font(.title)
                        .foregroundColor(.white)

                    Spacer()

                    Image(systemName: "chevron.backward")
                        .opacity(0)
                }
                .padding(.horizontal)
            }
            .frame(height: 56)
            
            
            List {
                // Sección Ajustes
                Section(header: Text("Ajustes").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                    // Fila Modo (Intacta)
                    HStack {
                        Image(systemName: "gearshape.fill")
                        Text("Modo")
                        Spacer()
                        Text("Oscuro/Claro")
                            .foregroundColor(.secondary)
                        Toggle("", isOn: $modoOscuroClaro)
                            .labelsHidden()
                            .tint(.blue)
                    }

                    // --- Fila IDIOMA (MODIFICADA A BOTÓN CON SLIDER) ---
                    Button(action: {
                        showLanguageSheet = true
                    }) {
                        HStack {
                            Image(systemName: "character.book.closed.fill")
                                .foregroundColor(.primary) // Color normal
                            Text("Idioma")
                                .foregroundColor(.primary)
                            Spacer()
                            Text(idioma) // Muestra la variable de estado
                                .foregroundColor(.secondary)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Section(header: Text("Información").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                    
                    // --- Fila NOMBRE (BOTÓN) ---
                    Button(action: {
                        showNameSheet = true
                    }) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.primary)
                            VStack(alignment: .leading) {
                                Text("Nombre")
                                    .foregroundColor(.primary)
                                Text(nombre)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // --- Fila PASSWORD (INTACTA) ---
                    HStack {
                        Image(systemName: "key.fill")
                        VStack(alignment: .leading){
                            Text("Password")
                            Text(contraseña)
                                .foregroundColor(.secondary)
                        }
                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }

                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        // --- CAMBIO: Ocultar el botón de retroceso nativo para usar el personalizado ---
        .navigationBarBackButtonHidden(true)
        
        // --- SHEET DEL NOMBRE ---
        .sheet(isPresented: $showNameSheet) {
            EditNameView(isPresented: $showNameSheet, currentName: $nombre)
                .presentationDetents([.height(350)])
                .presentationCornerRadius(30)
                .presentationDragIndicator(.hidden)
        }
        // --- SHEET DEL IDIOMA (NUEVO) ---
        .sheet(isPresented: $showLanguageSheet) {
            EditLanguageView(isPresented: $showLanguageSheet, currentLanguage: $idioma)
                .presentationDetents([.height(350)]) // Misma altura
                .presentationCornerRadius(30)
                .presentationDragIndicator(.hidden)
        }
    }
}

// --- VISTA MODAL PARA EDITAR IDIOMA (SLIDER/RUEDA) ---
struct EditLanguageView: View {
    @Binding var isPresented: Bool
    @Binding var currentLanguage: String
    
    // Variable temporal para el Picker
    @State private var selectedOption: String = "Español"
    
    // Las opciones disponibles
    let languages = ["Español", "Ingles"]
    
    var body: some View {
        VStack(spacing: 20) {
            // 1. Cabecera
            ZStack {
                Text("Selecciona Idioma")
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack {
                    Spacer()
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
            }
            .padding(.top, 20)
            
            // 2. Selector de Rueda (Solo 2 opciones)
            Picker("Idioma", selection: $selectedOption) {
                ForEach(languages, id: \.self) { language in
                    Text(language).tag(language)
                }
            }
            .pickerStyle(WheelPickerStyle()) // Estilo Rueda
            .labelsHidden()
            
            Spacer()
            
            // 3. Botones
            HStack(spacing: 15) {
                // Cancelar
                Button(action: {
                    isPresented = false
                }) {
                    Text("Cancelar")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                }
                
                // Confirmar
                Button(action: {
                    currentLanguage = selectedOption
                    isPresented = false
                }) {
                    Text("Confirmar")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(25)
                }
            }
        }
        .padding(25)
        .onAppear {
            // Cargar el idioma actual al abrir la ventana
            selectedOption = currentLanguage
        }
    }
}

// --- VISTA MODAL PARA EDITAR NOMBRE (INTACTA) ---
struct EditNameView: View {
    @Binding var isPresented: Bool
    @Binding var currentName: String
    @State private var tempName: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Text("Editar Nombre").font(.headline).fontWeight(.bold)
                HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } }
            }
            .padding(.top, 20)
            Spacer().frame(height: 10)
            
            TextField("Ingresa tu nombre", text: $tempName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .overlay(HStack { Spacer(); if !tempName.isEmpty { Button(action: { tempName = "" }) { Image(systemName: "multiply.circle.fill").foregroundColor(.gray).padding(.trailing, 10) } } })
            
            Spacer()
            HStack(spacing: 15) {
                Button(action: { isPresented = false }) {
                    Text("Cancelar").font(.system(size: 16, weight: .medium)).foregroundColor(.black).frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
                Button(action: { currentName = tempName; isPresented = false }) {
                    Text("Confirmar").font(.system(size: 16, weight: .medium)).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(25)
                }
                .disabled(tempName.isEmpty).opacity(tempName.isEmpty ? 0.6 : 1)
            }
        }.padding(25).onAppear { tempName = currentName }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
