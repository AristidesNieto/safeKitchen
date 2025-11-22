//
//  MedicDataView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI

struct MedicDataView: View {
    // --- NUEVO: Variable para controlar el regreso (Dismiss) ---
    @Environment(\.dismiss) var dismiss
    
    // --- Datos ---
    // Actualizamos 'sexo' para que arranque con "M" según tu requerimiento
    @State private var edad: String = "18"
    @State private var sexo: String = "M"
    @State private var altura: String = "178cm"
    @State private var peso: String = "75kg"

    // --- Estados para los modales ---
    @State private var showAgeSheet = false
    @State private var showSexSheet = false
    @State private var showHeightSheet = false
    @State private var showWeightSheet = false

    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
        
                // --- ENCABEZADO ---
                ZStack {
                    Color.blue
                        .ignoresSafeArea(edges: .top)
                    HStack {
                        // --- CAMBIO: Acción para regresar ---
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }
                        Spacer()
                        Text("Datos Medicos")
                            .font(.title)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "chevron.backward").opacity(0)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 56)
                
                // --- LISTA ---
                List {
                    Section(header: Text("Info basica").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                        
                        // --- Fila 1: Edad ---
                        Button(action: { showAgeSheet = true }) {
                            HStack {
                                Text("Edad")
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(edad).foregroundColor(.secondary)
                                Image(systemName: "chevron.right").font(.caption).foregroundColor(.gray).opacity(0.5)
                            }
                        }

                        // --- Fila 2: Sexo Biologico (MODIFICADA) ---
                        Button(action: { showSexSheet = true }) {
                            HStack {
                                Text("Sexo Biologico")
                                    .foregroundColor(.primary)
                                Spacer()
                                // Mostramos el valor actual (M o F)
                                Text(sexo)
                                    .foregroundColor(.secondary)
                                Image(systemName: "chevron.right").font(.caption).foregroundColor(.gray).opacity(0.5)
                            }
                        }

                        // --- Fila 3: Altura ---
                        Button(action: { showHeightSheet = true }) {
                            HStack {
                                Text("Altura")
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(altura).foregroundColor(.secondary)
                                Image(systemName: "chevron.right").font(.caption).foregroundColor(.gray).opacity(0.5)
                            }
                        }
                        // --- Fila 4: Peso ---
                        Button(action: { showWeightSheet = true }) {
                            HStack {
                                Text("Peso")
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(peso).foregroundColor(.secondary)
                                Image(systemName: "chevron.right").font(.caption).foregroundColor(.gray).opacity(0.5)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .scrollContentBackground(.hidden)
                .background(Color(.systemGray6))
            }
            .background(Color(.systemGray6))
            .ignoresSafeArea(edges: .bottom)
        }
        // --- CAMBIO: Ocultar el botón de retroceso nativo para usar el personalizado ---
        .navigationBarBackButtonHidden(true)
        
        // --- MODAL DE EDAD ---
        .sheet(isPresented: $showAgeSheet) {
            EditAgeView(isPresented: $showAgeSheet, currentAge: $edad)
                .presentationDetents([.height(350)])
                .presentationCornerRadius(30)
                .presentationDragIndicator(.hidden)
        }
        // --- MODAL DE SEXO (NUEVO) ---
        .sheet(isPresented: $showSexSheet) {
            EditSexView(isPresented: $showSexSheet, currentSex: $sexo)
                .presentationDetents([.height(350)]) // Misma altura
                .presentationCornerRadius(30)
                .presentationDragIndicator(.hidden)
        }
        // --- MODAL DE ALTURA ---
        .sheet(isPresented: $showHeightSheet) {
            EditHeightView(isPresented: $showHeightSheet, currentHeight: $altura)
                .presentationDetents([.height(350)])
                .presentationCornerRadius(30)
                .presentationDragIndicator(.hidden)
        }
        .sheet(isPresented: $showWeightSheet) {
            EditWeightView(isPresented: $showWeightSheet, currentWeight: $peso)
                .presentationDetents([.height(350)])
                .presentationCornerRadius(30)
                .presentationDragIndicator(.hidden)
        }
    }
}

// --- VISTA MODAL SEXO (NUEVA LÓGICA M/F) ---
struct EditSexView: View {
    @Binding var isPresented: Bool
    @Binding var currentSex: String // Recibe "M" o "F"
    
    // Variable temporal para el Picker
    @State private var selectedOption: String = "Masculino"
    
    let options = ["Masculino", "Femenino"]
    
    var body: some View {
        VStack(spacing: 20) {
            // 1. Cabecera
            ZStack {
                Text("Selecciona Sexo")
                    .font(.headline).fontWeight(.bold)
                HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } }
            }
            .padding(.top, 20)
            
            // 2. Selector de Rueda (Solo 2 opciones)
            Picker("Sexo", selection: $selectedOption) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            
            Spacer()
            
            // 3. Botones
            HStack(spacing: 15) {
                Button(action: { isPresented = false }) {
                    Text("Cancelar").font(.system(size: 16, weight: .medium)).foregroundColor(.black).frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
                
                Button(action: {
                    // Lógica de conversión: Guardamos solo la inicial
                    if selectedOption == "Masculino" {
                        currentSex = "M"
                    } else {
                        currentSex = "F"
                    }
                    isPresented = false
                }) {
                    Text("Confirmar").font(.system(size: 16, weight: .medium)).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(25)
                }
            }
        }
        .padding(25)
        .onAppear {
            // Cargar el estado actual al abrir
            if currentSex == "M" {
                selectedOption = "Masculino"
            } else {
                selectedOption = "Femenino"
            }
        }
    }
}

// --- VISTA MODAL EDAD (SIN CAMBIOS) ---
struct EditAgeView: View {
    @Binding var isPresented: Bool
    @Binding var currentAge: String
    @State private var selectedAge: Int = 18
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Text("Selecciona tu Edad").font(.headline).fontWeight(.bold)
                HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } }
            }
            .padding(.top, 20)
            Picker("Edad", selection: $selectedAge) { ForEach(1..<100) { number in Text("\(number)").tag(number) } }
            .pickerStyle(WheelPickerStyle()).labelsHidden()
            Spacer()
            HStack(spacing: 15) {
                Button(action: { isPresented = false }) { Text("Cancelar").font(.system(size: 16, weight: .medium)).foregroundColor(.black).frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray.opacity(0.5), lineWidth: 1)) }
                Button(action: { currentAge = "\(selectedAge)"; isPresented = false }) { Text("Confirmar").font(.system(size: 16, weight: .medium)).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(25) }
            }
        }.padding(25).onAppear { if let ageInt = Int(currentAge) { selectedAge = ageInt } }
    }
}

// --- VISTA MODAL ALTURA (SIN CAMBIOS) ---
struct EditHeightView: View {
    @Binding var isPresented: Bool
    @Binding var currentHeight: String
    @State private var selectedHeight: Int = 170
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Text("Selecciona tu Altura").font(.headline).fontWeight(.bold)
                HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } }
            }
            .padding(.top, 20)
            HStack {
                Picker("Altura", selection: $selectedHeight) { ForEach(50..<251) { number in Text("\(number)").tag(number) } }
                .pickerStyle(WheelPickerStyle()).labelsHidden()
                Text("cm").font(.headline).foregroundColor(.gray)
            }
            Spacer()
            HStack(spacing: 15) {
                Button(action: { isPresented = false }) { Text("Cancelar").font(.system(size: 16, weight: .medium)).foregroundColor(.black).frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray.opacity(0.5), lineWidth: 1)) }
                Button(action: { currentHeight = "\(selectedHeight)cm"; isPresented = false }) { Text("Confirmar").font(.system(size: 16, weight: .medium)).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(25) }
            }
        }.padding(25).onAppear { let cleanString = currentHeight.replacingOccurrences(of: "cm", with: ""); if let heightInt = Int(cleanString) { selectedHeight = heightInt } }
    }
}

// --- VISTA MODAL PESO
struct EditWeightView: View {
    @Binding var isPresented: Bool
    @Binding var currentWeight: String
    @State private var selectedWeight: Int = 170
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Text("Selecciona tu Peso").font(.headline).fontWeight(.bold)
                HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } }
            }
            .padding(.top, 20)
            HStack {
                Picker("Peso", selection: $selectedWeight) { ForEach(50..<251) { number in Text("\(number)").tag(number) } }
                .pickerStyle(WheelPickerStyle()).labelsHidden()
                Text("kg").font(.headline).foregroundColor(.gray)
            }
            Spacer()
            HStack(spacing: 15) {
                Button(action: { isPresented = false }) { Text("Cancelar").font(.system(size: 16, weight: .medium)).foregroundColor(.black).frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray.opacity(0.5), lineWidth: 1)) }
                Button(action: { currentWeight = "\(selectedWeight)kg"; isPresented = false }) { Text("Confirmar").font(.system(size: 16, weight: .medium)).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(25) }
            }
        }.padding(25).onAppear { let cleanString = currentWeight.replacingOccurrences(of: "kg", with: ""); if let weightInt = Int(cleanString) { selectedWeight = weightInt } }
    }
}

struct MedicDataView_Previews: PreviewProvider {
    static var previews: some View {
        MedicDataView()
    }
}
