//
//  ProfileFormView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 22/11/25.
//

import SwiftUI
import SwiftData

struct ProfileFormView: View {
    var allergyAnswers: [String: Bool]
    
    @Environment(\.modelContext) private var modelContext
    
    // Datos del formulario
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var biologicalSex: String = "Hombre"
    @State private var height: String = ""
    @State private var weight: String = ""
    
    let sexOptions = ["Hombre", "Mujer"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Datos Médicos")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(red: 15/255, green: 75/255, blue: 155/255))
                .padding(.top, 40)
            
            Text("Para personalizar tu experiencia")
                .foregroundColor(.black)
            
            Form {
                Section(header: Text("Información Básica")) {
                    TextField("Nombre", text: $name)
                    TextField("Edad", text: $age)
                        .keyboardType(.numberPad)
                    
                    Picker(selection: $biologicalSex, label: Text("Sexo Biológico").foregroundColor(.gray)) {
                        ForEach(sexOptions, id: \.self) { option in
                            Text(option)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    
                    TextField("Altura (cm)", text: $height)
                        .keyboardType(.decimalPad)
                    TextField("Peso (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                }
            }
            .scrollContentBackground(.hidden)
            
            Button(action: saveUser) {
                Text("FINALIZAR")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 10/255, green: 70/255, blue: 150/255))
                    .cornerRadius(25)
            }
            .padding(30)
            .disabled(name.isEmpty || age.isEmpty)
        }
        .background(Color(red: 235/255, green: 235/255, blue: 237/255))
    }
    
    func saveUser() {
        let ageInt = Int(age) ?? 0
        let heightDouble = Double(height) ?? 0.0
        let weightDouble = Double(weight) ?? 0.0
        
        let newUser = UserProfile(
            name: name,
            age: ageInt,
            biologicalSex: biologicalSex,
            height: heightDouble,
            weight: weightDouble,
            isAllergicToShrimp: allergyAnswers["camaron"] ?? false,
            isAllergicToNuts: allergyAnswers["nueces"] ?? false,
            isAllergicToEggs: allergyAnswers["huevos"] ?? false,
            isAllergicToFish: allergyAnswers["pescado"] ?? false,
            isAllergicToGluten: allergyAnswers["gluten"] ?? false,
            isAllergicToSoy: allergyAnswers["soya"] ?? false,
            isAllergicToDriedFruits: allergyAnswers["frutos_secos"] ?? false,
            isAllergicToMilk: allergyAnswers["lacteos"] ?? false
        )
        
        modelContext.insert(newUser)
        
        do {
            try modelContext.save()
            print("Usuario guardado con éxito. RootView debería cambiar ahora.")
        } catch {
            print("Error al guardar: \(error)")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: UserProfile.self, configurations: config)
    return ProfileFormView(allergyAnswers: [:]).modelContainer(container)
}
