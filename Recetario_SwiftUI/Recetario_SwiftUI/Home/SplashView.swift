//
//  SplashView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 21/11/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isBouncing = false
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            Image("chefcito")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.white)
                .scaleEffect(isBouncing ? 1.2 : 1.0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                        isBouncing = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            isActive = false //en false, el RootView cambia la vista
                        }
                    }
                }
        }
    }
}
