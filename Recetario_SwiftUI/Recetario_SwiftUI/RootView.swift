//
//  RootView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 21/11/25.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @State private var showSplash = true
    
    @Query var users: [UserProfile]
    
    var body: some View {
        if showSplash {
            //pasamos $showSplash para que el Splash pueda cambiarlo a false cuando termine.
            SplashView(isActive: $showSplash)
        } else {
            if users.isEmpty {
                OnboardingInfoView()
            } else {
                MainView()
                //HomeView() pero se le debe de pasar un parametro
            }
        }
    }
}
