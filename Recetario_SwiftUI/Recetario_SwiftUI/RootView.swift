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
    
    
    @Query(animation: .easeInOut) var users: [UserProfile]
    
    var body: some View {
        if showSplash {
            SplashView(isActive: $showSplash)
        } else {
            Group {
                if users.isEmpty {
                    OnboardingInfoView()
                        .transition(.opacity)
                } else {
                    
                    MainView()
                        .transition(.opacity)
                }
            }
        }
    }
}
