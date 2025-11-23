//
//  ProfileView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var modoOscuroClaro = false
    @State private var nombre: String = "Beto Perez"
    @State private var contraseña: String = "********"
    
    @State private var idioma: String = "Español"
    
    @State private var showNameSheet = false
    @State private var showLanguageSheet = false

    var body: some View {
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
                                Text(nombre)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                    
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
        .navigationBarBackButtonHidden(true)
        
        .sheet(isPresented: $showNameSheet) {
            EditNameView(isPresented: $showNameSheet, currentName: $nombre)
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
    }
}

struct EditLanguageView: View {
    @Binding var isPresented: Bool
    @Binding var currentLanguage: String
    
    @State private var selectedOption: String = "Español"
    
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
            
            Picker("Idioma", selection: $selectedOption) {
                ForEach(languages, id: \.self) { language in
                    Text(language).tag(language)
                }
            }
            .pickerStyle(WheelPickerStyle())
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
