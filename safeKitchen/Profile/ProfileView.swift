//
//  ProfileView.swift
//  safeKitchen
//
//  Created by Luis Angel Zempoalteca on 21/09/25.
//
import SwiftUI

struct ProfileView: View {
    @State private var modoOscuroClaro = false

    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                Color.blue
                    .ignoresSafeArea(edges: .top)
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }

                    Spacer()

                    Text("Perfil")
                        .font(.title)
                        .foregroundColor(.white)

                    Spacer()

                    Image(systemName: "chevron.backward")
                        .opacity(0)
                }
                .padding(.horizontal)
            }
            .frame(height: 56)
            
           
            List {
                // Sección Ajustes
                Section(header: Text("Ajustes").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                    HStack {
                        Image(systemName: "gearshape.fill")
                        Text("Modo")
                        Spacer()
                        Text("Oscuro/Claro")
                            .foregroundColor(.secondary)
                        Toggle("", isOn: $modoOscuroClaro)
                            .labelsHidden()
                            .tint(.blue)
                    }

                    HStack {
                        Image(systemName: "key.fill")
                        Text("Encuesta Inicial")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Image(systemName: "character.book.closed.fill")
                        Text("Idioma")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                }

                Section(header: Text("Información").font(.subheadline).foregroundColor(.secondary).textCase(nil)) {
                    HStack {
                        Image(systemName: "doc.text.fill")
                        Text("Condiciones Médicas")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Image(systemName: "checkmark.shield.fill")
                        Text("Datos Médicos")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
