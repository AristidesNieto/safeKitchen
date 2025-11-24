//
//  MedicDataView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//
import SwiftUI
import SwiftData

struct MedicDataView: View {
    @Query var users: [UserProfile]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var showAgeSheet = false
    @State private var showSexSheet = false
    @State private var showHeightSheet = false
    @State private var showWeightSheet = false
    
    // --- NUEVO: Estado para mostrar el Quiz ---
    @State private var showRetakeQuiz = false

    let headerBlue = Color(red: 15/255, green: 75/255, blue: 155/255)

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                ZStack {
                    Color.blue
                        .ignoresSafeArea(edges: .top)
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }
                        Spacer()
                        Text("Datos Médicos")
                            .font(.title)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "chevron.backward").opacity(0)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 56)
                
                if let user = users.first {
                    List {
                        Section(header: Text("Info básica").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                            Button(action: { showAgeSheet = true }) { rowContent(label: "Edad", value: "\(user.age)") }
                            Button(action: { showSexSheet = true }) { rowContent(label: "Sexo Biológico", value: user.biologicalSex) }
                            Button(action: { showHeightSheet = true }) { rowContent(label: "Altura", value: "\(Int(user.height)) cm") }
                            Button(action: { showWeightSheet = true }) { rowContent(label: "Peso", value: "\(Int(user.weight)) kg") }
                        }
                        
                        Section(header: Text("Alergias").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("¿Te equivocaste en el cuestionario inicial?")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                // --- BOTÓN MODIFICADO ---
                                Button(action: {
                                    // Activamos la bandera para abrir el quiz
                                    showRetakeQuiz = true
                                }) {
                                    Text("Tomar de nuevo")
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .background(Color.blue)
                                        .cornerRadius(20)
                                }
                                
                                Divider()
                                
                                Text("Resumen Alergias")
                                    .font(.headline)
                                    .padding(.top, 5)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    if !hasAnyAllergy(user: user) {
                                        Text("• Ninguna alergia registrada").foregroundColor(.gray)
                                    } else {
                                        if user.isAllergicToGluten { bulletPoint("Gluten") }
                                        if user.isAllergicToMilk { bulletPoint("Lactosa / Lácteos") }
                                        if user.isAllergicToNuts { bulletPoint("Nueces") }
                                        if user.isAllergicToShrimp { bulletPoint("Mariscos / Camarón") }
                                        if user.isAllergicToEggs { bulletPoint("Huevos") }
                                        if user.isAllergicToFish { bulletPoint("Pescado") }
                                        if user.isAllergicToSoy { bulletPoint("Soya") }
                                        if user.isAllergicToDriedFruits { bulletPoint("Frutos Secos") }
                                    }
                                }
                                .padding(.vertical, 5)
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemGray6))
                    
                    .sheet(isPresented: $showAgeSheet) {
                        EditAgeView(isPresented: $showAgeSheet, currentAge: Binding(get: { String(user.age) }, set: { if let val = Int($0) { user.age = val } }))
                            .presentationDetents([.height(350)]).presentationCornerRadius(30).presentationDragIndicator(.hidden)
                    }
                    .sheet(isPresented: $showSexSheet) {
                        EditSexView(isPresented: $showSexSheet, currentSex: Binding(get: { user.biologicalSex }, set: { user.biologicalSex = $0 }))
                            .presentationDetents([.height(350)]).presentationCornerRadius(30).presentationDragIndicator(.hidden)
                    }
                    .sheet(isPresented: $showHeightSheet) {
                        EditHeightView(isPresented: $showHeightSheet, currentHeight: Binding(get: { "\(Int(user.height))cm" }, set: { let clean = $0.replacingOccurrences(of: "cm", with: ""); if let val = Double(clean) { user.height = val } }))
                            .presentationDetents([.height(350)]).presentationCornerRadius(30).presentationDragIndicator(.hidden)
                    }
                    .sheet(isPresented: $showWeightSheet) {
                        EditWeightView(isPresented: $showWeightSheet, currentWeight: Binding(get: { "\(Int(user.weight))kg" }, set: { let clean = $0.replacingOccurrences(of: "kg", with: ""); if let val = Double(clean) { user.weight = val } }))
                            .presentationDetents([.height(350)]).presentationCornerRadius(30).presentationDragIndicator(.hidden)
                    }
                    // --- NUEVO: Sheet para el Quiz ---
                    .fullScreenCover(isPresented: $showRetakeQuiz) {
                        // Le pasamos el usuario actual para que el quiz sepa que es una EDICIÓN y no uno nuevo
                        alergia(currentUser: user)
                    }
                    
                } else {
                    VStack {
                        Text("No se encontró perfil médico.")
                        Button("Crear Perfil") { dismiss() }
                    }
                }
            }
            .background(Color(.systemGray6))
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func rowContent(label: String, value: String) -> some View {
        HStack { Text(label).foregroundColor(.primary); Spacer(); Text(value).foregroundColor(.secondary); Image(systemName: "chevron.right").font(.caption).foregroundColor(.gray).opacity(0.5) }
    }
    func bulletPoint(_ text: String) -> some View {
        HStack(spacing: 10) { Circle().fill(Color.gray).frame(width: 6, height: 6); Text(text).foregroundColor(.gray) }
    }
    func hasAnyAllergy(user: UserProfile) -> Bool {
        return user.isAllergicToGluten || user.isAllergicToMilk || user.isAllergicToNuts || user.isAllergicToShrimp || user.isAllergicToEggs || user.isAllergicToFish || user.isAllergicToSoy || user.isAllergicToDriedFruits
    }
}

// (Mantén aquí abajo tus struct EditSexView, EditAgeView, etc. tal cual las tenías, no cambian)
// ... (Copiar el resto del archivo original aquí si no lo tienes a la mano dímelo)

struct EditSexView: View {
    @Binding var isPresented: Bool
    @Binding var currentSex: String
    @State private var selectedOption: String = "Masculino"
    let options = ["Masculino", "Femenino"]
    var body: some View {
        VStack(spacing: 20) {
            header(title: "Selecciona Sexo")
            Picker("Sexo", selection: $selectedOption) { ForEach(options, id: \.self) { option in Text(option).tag(option) } }.pickerStyle(WheelPickerStyle()).labelsHidden()
            Spacer()
            buttons(onConfirm: {
                currentSex = (selectedOption == "Masculino") ? "Hombre" : "Mujer" // Normalizamos a lo que espera la DB si es necesario
            })
        }.padding(25).onAppear { selectedOption = (currentSex == "Hombre" || currentSex == "M") ? "Masculino" : "Femenino" }
    }
    func header(title: String) -> some View { ZStack { Text(title).font(.headline).fontWeight(.bold); HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } } }.padding(.top, 20) }
    func buttons(onConfirm: @escaping () -> Void) -> some View { HStack(spacing: 15) { Button("Cancelar") { isPresented = false }.buttonStyle(CancelStyle()); Button("Confirmar") { onConfirm(); isPresented = false }.buttonStyle(ConfirmStyle()) } }
}

struct EditAgeView: View {
    @Binding var isPresented: Bool
    @Binding var currentAge: String
    @State private var selectedAge: Int = 18
    var body: some View {
        VStack(spacing: 20) {
            header(title: "Selecciona tu Edad")
            Picker("Edad", selection: $selectedAge) { ForEach(1..<100) { number in Text("\(number)").tag(number) } }.pickerStyle(WheelPickerStyle()).labelsHidden()
            Spacer()
            buttons(onConfirm: { currentAge = "\(selectedAge)" })
        }.padding(25).onAppear { if let val = Int(currentAge) { selectedAge = val } }
    }
    func header(title: String) -> some View { ZStack { Text(title).font(.headline).fontWeight(.bold); HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } } }.padding(.top, 20) }
    func buttons(onConfirm: @escaping () -> Void) -> some View { HStack(spacing: 15) { Button("Cancelar") { isPresented = false }.buttonStyle(CancelStyle()); Button("Confirmar") { onConfirm(); isPresented = false }.buttonStyle(ConfirmStyle()) } }
}

struct EditHeightView: View {
    @Binding var isPresented: Bool
    @Binding var currentHeight: String
    @State private var selectedHeight: Int = 170
    var body: some View {
        VStack(spacing: 20) {
            header(title: "Selecciona tu Altura")
            HStack { Picker("", selection: $selectedHeight) { ForEach(50..<251) { number in Text("\(number)").tag(number) } }.pickerStyle(WheelPickerStyle()).labelsHidden(); Text("cm").font(.headline).foregroundColor(.gray) }
            Spacer()
            buttons(onConfirm: { currentHeight = "\(selectedHeight)cm" })
        }.padding(25).onAppear { let clean = currentHeight.replacingOccurrences(of: "cm", with: ""); if let val = Int(clean) { selectedHeight = val } }
    }
    func header(title: String) -> some View { ZStack { Text(title).font(.headline).fontWeight(.bold); HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } } }.padding(.top, 20) }
    func buttons(onConfirm: @escaping () -> Void) -> some View { HStack(spacing: 15) { Button("Cancelar") { isPresented = false }.buttonStyle(CancelStyle()); Button("Confirmar") { onConfirm(); isPresented = false }.buttonStyle(ConfirmStyle()) } }
}

struct EditWeightView: View {
    @Binding var isPresented: Bool
    @Binding var currentWeight: String
    @State private var selectedWeight: Int = 70
    var body: some View {
        VStack(spacing: 20) {
            header(title: "Selecciona tu Peso")
            HStack { Picker("", selection: $selectedWeight) { ForEach(30..<200) { number in Text("\(number)").tag(number) } }.pickerStyle(WheelPickerStyle()).labelsHidden(); Text("kg").font(.headline).foregroundColor(.gray) }
            Spacer()
            buttons(onConfirm: { currentWeight = "\(selectedWeight)kg" })
        }.padding(25).onAppear { let clean = currentWeight.replacingOccurrences(of: "kg", with: ""); if let val = Int(clean) { selectedWeight = val } }
    }
    func header(title: String) -> some View { ZStack { Text(title).font(.headline).fontWeight(.bold); HStack { Spacer(); Button(action: { isPresented = false }) { Image(systemName: "xmark").foregroundColor(.black).font(.system(size: 16, weight: .bold)) } } }.padding(.top, 20) }
    func buttons(onConfirm: @escaping () -> Void) -> some View { HStack(spacing: 15) { Button("Cancelar") { isPresented = false }.buttonStyle(CancelStyle()); Button("Confirmar") { onConfirm(); isPresented = false }.buttonStyle(ConfirmStyle()) } }
}

// Estilos de Botón para no repetir código
struct CancelStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.system(size: 16, weight: .medium)).foregroundColor(.black).frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray.opacity(0.5), lineWidth: 1)).opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
struct ConfirmStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.system(size: 16, weight: .medium)).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(25).opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

#Preview {
    // Preview Mockeado
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: UserProfile.self, configurations: config)
    let user = UserProfile(name: "Luis", age: 22, biologicalSex: "Hombre", height: 180, weight: 78, isAllergicToShrimp: true)
    container.mainContext.insert(user)
    return MedicDataView().modelContainer(container)
}
