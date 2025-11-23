import SwiftUI

// (Los colores siguen igual que antes)
extension Color {
    static let titleBlue = Color(red: 15/255, green: 75/255, blue: 155/255)
    static let buttonBlue = Color(red: 10/255, green: 70/255, blue: 150/255)
    static let textGray = Color(red: 60/255, green: 60/255, blue: 60/255)
    static let backgroundGray = Color(red: 235/255, green: 235/255, blue: 237/255)
    static let instructionBoxGray = Color(red: 225/255, green: 225/255, blue: 230/255)
    static let instructionShadowBlue = Color(red: 100/255, green: 120/255, blue: 180/255)
}

struct OnboardingInfoView: View {
    @State private var navigateToAlergia = false

    var body: some View {
        NavigationStack{
            ZStack {
                // Fondo general de la pantalla
                Color.backgroundGray.edgesIgnoringSafeArea(.all)
                
                // VStack principal que contiene TODO
                VStack {
                    
                    
                    ZStack(alignment: .top) {
                        
                        VStack(spacing: 25) {
                            VStack(spacing: 10) {
                                Text("Antes de empezar")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.titleBlue)
                                
                                Text("necesitamos saber un\npoco de ti")
                                    .font(.system(size: 18))
                                    .foregroundColor(.textGray)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.top, 40)
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.instructionShadowBlue)
                                    .offset(x: 10, y: 10)
                                
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.instructionBoxGray)
                                
                                Text("Contesta el siguiente quiz\nde esta manera")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            .frame(height: 100)
                            .padding(.horizontal, 20)
                            
                            
                            Spacer()
                        }
                        
                        .frame(maxHeight: 450)
                        
                        
                        Image("imagen_instrucciones_swipe")
                            .resizable()
                            .scaledToFit()
                        
                            .padding(.top, 300)
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        print("Navegar a alergia.swift")
                        navigateToAlergia = true
                    }) {
                        Text("SIGUIENTE")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        //.frame(maxWidth: .infinity)
                            .frame(minWidth: 130)
                            .padding()
                            .background(Color.buttonBlue)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }
                .navigationDestination(isPresented: $navigateToAlergia) {
                    alergia()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct OnboardingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingInfoView()
    }
}
