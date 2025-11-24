//
//  ProfileView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI
import SwiftData // 1. Importamos SwiftData

struct ProfileView: View {
    // 2. Obtenemos el usuario de la base de datos igual que en MedicDataView
    @Query var users: [UserProfile]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    // Mantenemos estos como State porque usualmente son preferencias de la app,
    // a menos que tu modelo UserProfile tenga campos como 'language' o 'isDarkMode'.
    @State private var modoOscuroClaro = false
    //@State private var contraseña: String = "********"
    @State private var idioma: String = "Español"
    
    @State private var showNameSheet = false
    @State private var showLanguageSheet = false

    var body: some View {
        NavigationStack { // Agregamos NavigationStack para consistencia
            VStack(spacing: 0) {
                
                ZStack {
                    Color.blue
                        .ignoresSafeArea(edges: .top)
                    HStack {
                        Button(action: {
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
                
                // 3. Verificamos que exista el usuario
                if let user = users.first {
                    List {
                        Section(header: Text("Ajustes").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
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

                            Button(action: {
                                showLanguageSheet = true
                            }) {
                                HStack {
                                    Image(systemName: "character.book.closed.fill")
                                        .foregroundColor(.primary)
                                    Text("Idioma")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Text(idioma)
                                        .foregroundColor(.secondary)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }

                        Section(header: Text("Información").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                            
                            Button(action: {
                                showNameSheet = true
                            }) {
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.primary)
                                    VStack(alignment: .leading) {
                                        Text("Nombre")
                                            .foregroundColor(.primary)
                                        // 4. Usamos el nombre real de SwiftData
                                        Text(user.name)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                            }

                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    // 5. Sheets conectados a SwiftData
                    .sheet(isPresented: $showNameSheet) {
                        EditNameView(isPresented: $showNameSheet, currentName: Binding(
                            get: { user.name },
                            set: { user.name = $0 }
                        ))
                        .presentationDetents([.height(350)])
                        .presentationCornerRadius(30)
                        .presentationDragIndicator(.hidden)
                    }
                    .sheet(isPresented: $showLanguageSheet) {
                        EditLanguageView(isPresented: $showLanguageSheet, currentLanguage: $idioma)
                            .presentationDetents([.height(350)])
                            .presentationCornerRadius(30)
                            .presentationDragIndicator(.hidden)
                    }
                    
                } else {
                    // Estado vacio por si no hay usuario (igual que en MedicDataView)
                    VStack {
                        Text("No se encontró perfil de usuario.")
                        Button("Regresar") { dismiss() }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

// --- SUBVIEWS (Sin cambios lógicos, solo visuales o de estructura interna si fuera necesario) ---

struct EditLanguageView: View {
    @Binding var isPresented: Bool
    @Binding var currentLanguage: String
    
    @State private var selectedOption: String = "Español"
    
    let languages = ["Español", "Ingles"]
    
    var body: some View {
        VStack(spacing: 20) {
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
            
            Picker("Idioma", selection: $selectedOption) {
                ForEach(languages, id: \.self) { language in
                    Text(language).tag(language)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            
            Spacer()
            
            HStack(spacing: 15) {
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
            selectedOption = currentLanguage
        }
    }
}

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
                Button(action: {
                    // Al confirmar, esto actualiza el Binding que a su vez actualiza SwiftData
                    currentName = tempName
                    isPresented = false
                }) {
                    Text("Confirmar").font(.system(size: 16, weight: .medium)).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(25)
                }
                .disabled(tempName.isEmpty).opacity(tempName.isEmpty ? 0.6 : 1)
            }
        }.padding(25).onAppear { tempName = currentName }
    }
}

// Preview Mockeado para que funcione en el Canvas (Igual que en tu MedicDataView)
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: UserProfile.self, configurations: config)
    let user = UserProfile(name: "Luis Angel", age: 22, biologicalSex: "Hombre", height: 180, weight: 78, isAllergicToShrimp: true)
    container.mainContext.insert(user)
    return ProfileView().modelContainer(container)
}
