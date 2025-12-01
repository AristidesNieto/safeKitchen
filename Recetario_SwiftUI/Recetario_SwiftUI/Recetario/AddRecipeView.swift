//
//  AddRecipeView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 23/11/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddRecipeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // Campos del formulario
    @State private var title: String = ""
    @State private var instructions: String = ""
    @State private var ingredientsText: String = ""
    
    // Para la foto
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    // Para alérgenos
    @State private var selectedAllergens: Set<Allergen> = []
    
    // Estado para el foco del teclado
    @FocusState private var isInputActive: Bool
    
    // --- NUEVO: Estado para mostrar la alerta de confirmación ---
    @State private var showDiscardAlert = false
    
    // --- NUEVO: Detectamos si el usuario ha escrito algo ---
    var hasChanges: Bool {
        return !title.isEmpty || !instructions.isEmpty || !ingredientsText.isEmpty || selectedImageData != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                // SECCIÓN 1: FOTO
                Section(header: Text("Foto del Platillo")) {
                    HStack {
                        Spacer()
                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .cornerRadius(12)
                                .clipped()
                        } else {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                                .frame(width: 150, height: 150)
                                .background(Color(.systemGray5))
                                .cornerRadius(12)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            HStack {
                                Image(systemName: "photo")
                                Text("Seleccionar foto de la galería")
                            }
                            .foregroundColor(.blue)
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                }
                
                // SECCIÓN 2: DATOS BÁSICOS
                Section(header: Text("Información")) {
                    TextField("Nombre de la receta", text: $title)
                        .focused($isInputActive)
                    
                    VStack(alignment: .leading) {
                        Text("Ingredientes (uno por línea)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextEditor(text: $ingredientsText)
                            .frame(height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
                            .focused($isInputActive)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Instrucciones de preparación")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextEditor(text: $instructions)
                            .frame(height: 150)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
                            .focused($isInputActive)
                    }
                }
                
                // SECCIÓN 3: ALÉRGENOS
                Section(header: Text("Contiene Alérgenos")) {
                    Text("Marca si la receta contiene alguno de estos:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Toggle("Camarón", isOn: binding(for: .shrimp))
                    Toggle("Nueces", isOn: binding(for: .nuts))
                    Toggle("Huevo", isOn: binding(for: .eggs))
                    Toggle("Pescado", isOn: binding(for: .fish))
                    Toggle("Gluten", isOn: binding(for: .gluten))
                    Toggle("Soya", isOn: binding(for: .soy))
                    Toggle("Frutos Secos", isOn: binding(for: .driedFruits))
                    Toggle("Lácteos", isOn: binding(for: .dairy))
                }
            }
            .navigationTitle("Nueva Receta")
            .navigationBarTitleDisplayMode(.inline)
            
            // --- NUEVO: Bloqueamos el swipe si hay cambios ---
            .interactiveDismissDisabled(hasChanges)
            
            .toolbar {
                // Botón Cancelar Inteligente
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        if hasChanges {
                            // Si hay cambios, pedimos confirmación
                            showDiscardAlert = true
                        } else {
                            // Si está vacío, salimos directo
                            dismiss()
                        }
                    }
                }
                
                // Botón Guardar
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        saveRecipe()
                    }
                    .disabled(title.isEmpty || instructions.isEmpty)
                }
                
                // Barra de teclado
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Listo") {
                        isInputActive = false
                    }
                    .fontWeight(.bold)
                }
            }
            // --- NUEVO: La alerta de confirmación ---
            .alert("¿Descartar cambios?", isPresented: $showDiscardAlert) {
                Button("Descartar", role: .destructive) {
                    dismiss()
                }
                Button("Seguir editando", role: .cancel) { }
            } message: {
                Text("Si sales ahora, perderás la información de la receta.")
            }
        }
    }
    
    private func binding(for allergen: Allergen) -> Binding<Bool> {
        Binding(
            get: { selectedAllergens.contains(allergen) },
            set: { isSelected in
                if isSelected {
                    selectedAllergens.insert(allergen)
                } else {
                    selectedAllergens.remove(allergen)
                }
            }
        )
    }
    
    private func saveRecipe() {
        let ingredientsArray = ingredientsText
            .components(separatedBy: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        
        let newRecipe = UserRecipe(
            title: title,
            imageData: selectedImageData,
            ingredients: ingredientsArray,
            instructions: instructions,
            containsAllergens: Array(selectedAllergens)
        )
        
        modelContext.insert(newRecipe)
        dismiss()
    }
}

#Preview {
    AddRecipeView()
}
