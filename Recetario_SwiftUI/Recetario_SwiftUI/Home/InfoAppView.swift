//
//  InfoAppView.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 25/11/25.
//

import SwiftUI

struct InfoSection: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

struct InfoAppView: View {
    @Environment(\.dismiss) var dismiss
    
    let infoData: [InfoSection] = [
        InfoSection(title: "Alergia Alimentaria", content: "La respuesta normal a la ingestión de los alimentos es la tolerancia. En las personas con alergia alimentaria, el sistema inmunitario genera una respuesta alterada que desencadena síntomas como prurito oral, urticaria, hinchazón, dolor abdominal, diarrea, vómito, tos, falta de aire, e incluso reacciones graves como anafilaxia.\n\nEs vital acudir a Alergología para un correcto diagnóstico y no incurrir en dietas deficientes."),
        
        InfoSection(title: "¿Cómo se diagnostica?", content: "El primer paso es acudir a consulta de Alergología. Se realiza una historia clínica contemplando el alimento implicado, los síntomas, el tiempo de reacción, etc.\n\nEn base a esto se plantean pruebas cutáneas, serológicas (sangre) o de tolerancia para establecer un diagnóstico correcto."),
        
        InfoSection(title: "¿Cómo se trata?", content: "El tratamiento consiste en la eliminación del alimento de la dieta y la educación del paciente para minimizar ingestiones accidentales.\n\nEs crucial saber reconocer los síntomas para actuar rápido. En reacciones graves (anafilaxia), el tratamiento es adrenalina intramuscular.\n\nActualmente existen protocolos de inmunoterapia oral (ITO) para leche y huevo en niños para mejorar su calidad de vida."),
        
        InfoSection(title: "Recomendaciones Generales", content: "1.- Identificar el alimento responsable.\n2.- Leer exhaustivamente las etiquetas (incluyendo trazas).\n3.- Avisar del diagnóstico en la escuela, trabajo y familia.\n4.- Saber reconocer síntomas graves y cómo actuar."),
        
        InfoSection(title: "Alergia a Leche de Vaca", content: "Es la más frecuente en lactantes. Síntomas desde prurito hasta anafilaxia. Más del 70% la superan en los primeros 5 años.\n\nEs indispensable evitar la proteína de leche y acudir al especialista para buscar alternativas nutricionales."),
        
        InfoSection(title: "Alergia a Huevo", content: "Común en bebés y niños. La mayoría la supera a los 5 años. Los alérgenos están principalmente en la clara, pero se deben evitar clara y yema.\n\nRequiere diagnóstico preciso por la importancia nutricional del huevo."),
        
        InfoSection(title: "Alergia a Frutas y Verduras", content: "Síntomas desde comezón en la boca hasta reacciones graves. A veces se toleran cocinadas (en almíbar), pero depende del caso. Es vital identificar cuál es la causante para evitarla."),
        
        InfoSection(title: "Cereales, Legumbres y Frutos Secos", content: "Incluye trigo, maíz, arroz, lentejas, cacahuate (maní), nueces, almendras, pistaches, etc.\n\nPueden causar desde urticaria hasta asma (al inhalar harinas) o anafilaxia. El cacahuate y los frutos secos suelen ser causas frecuentes de reacciones severas."),
        
        InfoSection(title: "Alergia a Pescado", content: "Los síntomas suelen aparecer en las primeras dos horas. También puede haber reacción por inhalar los vapores de cocción.\n\nSer alérgico al pescado NO implica ser alérgico al marisco, son grupos distintos."),
        
        InfoSection(title: "Alergia a Marisco", content: "Incluye crustáceos (camarón, langosta) y moluscos (almejas, pulpo). Reacciones desde locales hasta anafilaxia.\n\nEs independiente de la alergia al pescado. Se debe evitar el alimento y sus trazas rigurosamente.")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color.blue
                    .ignoresSafeArea(edges: .top)
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                    Spacer()
                    Text("Información")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.backward").opacity(0)
                }
                .padding(.horizontal)
                .padding(.bottom, 15)
            }
            .frame(height: 60)
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack(spacing: 5) {
                        Text("SAFE KITCHEN")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .tracking(2)
                        
                        Text("Guía de Alergias")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                    ForEach(infoData) { item in
                        InfoAccordionRow(title: item.title, content: item.content)
                    }
                    
                    Text("Fuentes: https://www.foodallergy.org/")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 30)
                        .padding(.bottom, 50)
                }
                .padding(.horizontal)
            }
            .background(Color(.systemGroupedBackground)) // Fondo gris suave adaptable
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct InfoAccordionRow: View {
    let title: String
    let content: String
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Botón Título
            Button(action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary) // Adaptable a modo oscuro/claro
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
                .padding()
                // CAMBIO: Fondo adaptable del sistema en lugar de Color.white fijo
                .background(Color(UIColor.secondarySystemGroupedBackground))
            }
            
            if isExpanded {
                Divider()
                Text(content)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    // CAMBIO: Fondo adaptable del sistema en lugar de Color.white fijo
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    InfoAppView()
}
