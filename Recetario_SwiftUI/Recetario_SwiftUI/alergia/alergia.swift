////
//  alergia.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//
import SwiftUI
import SwiftData

struct QuizItem: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let key: String
}

struct alergia: View {
    // --- NUEVO: Variables para manejar SwiftData y cierre de ventana ---
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // --- NUEVO: Usuario opcional. Si nos lo pasan, estamos en MODO EDICIÓN ---
    var currentUser: UserProfile?
    
    @State var cards: [QuizItem] = [
        QuizItem(text: "¿Eres alérgico al camarón?", key: "camaron"),
        QuizItem(text: "¿Tienes problemas con las nueces?", key: "nueces"),
        QuizItem(text: "¿Tienes problemas con los huevos?", key: "huevos"),
        QuizItem(text: "¿Eres alérgico al pescado?", key: "pescado"),
        QuizItem(text: "¿Eres alérgico al gluten?", key: "gluten"),
        QuizItem(text: "¿Eres alérgico a la soya?", key: "soya"),
        QuizItem(text: "¿Tienes alergia a los frutos secos?", key: "frutos_secos"),
        QuizItem(text: "¿Tienes alguna alergia a los lácteos?", key: "lacteos")
    ]
    
    @State private var answers: [String: Bool] = [:]
    @State private var offset: CGSize = .zero
    @State private var navigateToProfile = false
    @State private var totalCards: Int = 0
    
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.30, blue: 0.75)
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    // Convertimos el texto "Atrás" en un botón funcional
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "chevron.left")
                            Text("Atrás")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                Spacer()

                ZStack {
                    if cards.isEmpty {
                        Text("¡Listo!")
                            .font(.title)
                            .foregroundColor(.white)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    // --- LÓGICA IMPORTANTE ---
                                    if let user = currentUser {
                                        // 1. MODO EDICIÓN: Actualizamos al usuario existente
                                        updateUserAllergies(user)
                                        // 2. Cerramos el quiz
                                        dismiss()
                                    } else {
                                        // 3. MODO ONBOARDING: Vamos a crear perfil
                                        navigateToProfile = true
                                    }
                                }
                            }
                    } else {
                        ForEach(cards) { card in
                            let isTopCard = card == cards.last
                            
                            QuestionCardView(
                                questionText: card.text,
                                index: (totalCards - cards.count) + 1,
                                totalQuestions: totalCards
                            )
                            .scaleEffect(isTopCard ? 1 : 0.9)
                            .offset(y: isTopCard ? 0 : 10)
                            .opacity(isTopCard ? 1 : 0.5)
                            .offset(x: isTopCard ? offset.width : 0, y: isTopCard ? offset.height : 0)
                            .rotationEffect(.degrees(isTopCard ? Double(offset.width / 10) : 0))
                            .gesture(
                                isTopCard ?
                                DragGesture()
                                    .onChanged { gesture in
                                        self.offset = gesture.translation
                                    }
                                    .onEnded { _ in
                                        detectSwipe(card: card)
                                    }
                                : nil
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .offset(y: -50)

                if !cards.isEmpty {
                    HStack {
                        Text("NO")
                            .bold()
                            .foregroundColor(.red)
                            .opacity(offset.width < -50 ? 1 : 0.2)
                        Spacer()
                        Text("SÍ")
                            .bold()
                            .foregroundColor(.green)
                            .opacity(offset.width > 50 ? 1 : 0.2)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                }
                
                Spacer()
            }
            
            .navigationDestination(isPresented: $navigateToProfile) {
                ProfileFormView(allergyAnswers: answers)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            if totalCards == 0 { totalCards = cards.count }
        }
        .navigationBarBackButtonHidden(true) // Ocultamos botón nativo para usar el nuestro
    }
    
    // --- FUNCIÓN NUEVA: Actualiza solo las alergias ---
    func updateUserAllergies(_ user: UserProfile) {
        user.isAllergicToShrimp = answers["camaron"] ?? false
        user.isAllergicToNuts = answers["nueces"] ?? false
        user.isAllergicToEggs = answers["huevos"] ?? false
        user.isAllergicToFish = answers["pescado"] ?? false
        user.isAllergicToGluten = answers["gluten"] ?? false
        user.isAllergicToSoy = answers["soya"] ?? false
        user.isAllergicToDriedFruits = answers["frutos_secos"] ?? false
        user.isAllergicToMilk = answers["lacteos"] ?? false
        
        // Guardamos cambios en SwiftData
        try? modelContext.save()
    }
    
    func detectSwipe(card: QuizItem) {
        if offset.width > 100 {
            answers[card.key] = true
            removeCard()
        } else if offset.width < -100 {
            answers[card.key] = false
            removeCard()
        } else {
            withAnimation(.spring()) {
                offset = .zero
            }
        }
    }
    
    func removeCard() {
        withAnimation {
            _ = cards.popLast()
            offset = .zero
        }
    }
}

#Preview {
    alergia()
}
