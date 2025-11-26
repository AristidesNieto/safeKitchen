//
//  Recetario_SwiftUIApp.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import SwiftUI
import SwiftData

@main
struct Recetario_SwiftUIApp: App {
    // 1. Escuchamos las preferencias globales
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("userLanguage") private var userLanguage = "es"

    var body: some Scene {
        WindowGroup {
            RootView()
                // 2. Aplicamos el MODO OSCURO o CLARO a toda la app
                .preferredColorScheme(isDarkMode ? .dark : .light)
                // 3. Aplicamos el IDIOMA a toda la app
                .environment(\.locale, Locale(identifier: userLanguage))
        }
        // 4. Cargamos la base de datos (Perfil + Recetas Personales)
        .modelContainer(for: [UserProfile.self, UserRecipe.self])
    }
}
