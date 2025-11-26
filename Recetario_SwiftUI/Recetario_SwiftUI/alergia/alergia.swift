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
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var currentUser: UserProfile?
    
    let infoDictionary: [String: (title: String, body: String)] = [
        "lacteos": ("Alergia a Lácteos", "Es vital evitar la proteína de leche de vaca. Frecuente en lactantes. Síntomas desde hinchazón hasta anafilaxia. Más del 70% la superan en los primeros 5 años."),
        "huevos": ("Alergia a Huevo", "Evita tanto la clara como la yema. Los alérgenos principales están en la clara. Común en niños pequeños, suele superarse a los 5 años."),
        "frutos_secos": ("Frutos Secos", "Incluye almendra, avellana, nuez, pistache, etc. Riesgo alto de reacciones graves. Evita también la inhalación de partículas."),
        "pescado": ("Alergia a Pescado", "Los síntomas aparecen en las primeras 2 horas. Evita también los vapores de cocción. No implica necesariamente alergia al marisco."),
        "camaron": ("Alergia a Marisco", "Incluye crustáceos (camarón, langosta) y moluscos. Reacciones rápidas. Evita alimentos procesados que puedan contener trazas."),
        "soya": ("Alergia a Soya", "Es una legumbre muy usada en la industria. Lee exhaustivamente las etiquetas de productos procesados para evitar ingestas accidentales."),
        "gluten": ("Cereales / Gluten", "Evita trigo, centeno, cebada y avena. Revisa etiquetas por posible contaminación cruzada o trazas en alimentos procesados."),
        "nueces": ("Alergia a Nueces", "Suelen causar reacciones severas. Evita nuez de castilla, pecana, macadamia y ten cuidado con postres o salsas que las contengan.")
    ]
    
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
    
    @State private var showInfoModal = false
    @State private var currentInfoTitle = ""
    @State private var currentInfoBody = ""
    @State private var pendingCardToRemove: QuizItem?
    
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.30, blue: 0.75)
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Header
                HStack {
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
                                    if let user = currentUser {
                                        updateUserAllergies(user)
                                        dismiss()
                                    } else {
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

                // Indicadores visuales
                if !cards.isEmpty && !showInfoModal {
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
            
            if showInfoModal {
                Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                        .padding(.top, 30)
                    
                    Text(currentInfoTitle)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    Text(currentInfoBody)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Button(action: {
                        withAnimation {
                            showInfoModal = false
                            removeCard()
                        }
                    }) {
                        Text("Entendido, continuar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    .padding(20)
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding(30)
                .transition(.scale)
                .zIndex(100)
            }
            
        }
        
        .navigationDestination(isPresented: $navigateToProfile) {
            ProfileFormView(allergyAnswers: answers)
                .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            if totalCards == 0 { totalCards = cards.count }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func updateUserAllergies(_ user: UserProfile) {
        user.isAllergicToShrimp = answers["camaron"] ?? false
        user.isAllergicToNuts = answers["nueces"] ?? false
        user.isAllergicToEggs = answers["huevos"] ?? false
        user.isAllergicToFish = answers["pescado"] ?? false
        user.isAllergicToGluten = answers["gluten"] ?? false
        user.isAllergicToSoy = answers["soya"] ?? false
        user.isAllergicToDriedFruits = answers["frutos_secos"] ?? false
        user.isAllergicToMilk = answers["lacteos"] ?? false
        
        try? modelContext.save()
    }
    
    func detectSwipe(card: QuizItem) {
        if offset.width > 100 {
            answers[card.key] = true
            
            if let info = infoDictionary[card.key] {
                currentInfoTitle = info.title
                currentInfoBody = info.body
            } else {
                currentInfoTitle = "Información Importante"
                currentInfoBody = "Es importante evitar este alimento y consultar a tu especialista."
            }
            
            pendingCardToRemove = card
            
            withAnimation(.spring()) {
                showInfoModal = true
                offset = .zero
            }
            
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
            pendingCardToRemove = nil
        }
    }
}

#Preview {
    alergia()
}
