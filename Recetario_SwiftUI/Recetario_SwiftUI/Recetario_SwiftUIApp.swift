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
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: UserProfile.self)
    }
}
