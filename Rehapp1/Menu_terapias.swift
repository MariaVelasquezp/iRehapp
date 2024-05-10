//
//  Menu_terapias.swift
//  Rehapp
//
//  Created by Maria Velásquez Peña on 3/29/24.
//

import SwiftUI

class GlobalState: ObservableObject {
    @Published var terapiaCompletaSelected = false
    @Published var terapiaSimplificadaSelected = false
    @Published var terapiaLibreSelected = false
    
    static let shared = GlobalState()
    
    private init() {}
}

struct TerapiasContent: View {
    @ObservedObject var globalState = GlobalState.shared
    @State private var navigateToNewViewCom = false
    @State private var navigateToNewViewSim = false
    @State private var navigateToNewViewLib = false
    @Binding var stimParams: StimParameters
    @ObservedObject var module: DiscoveredPeripheral
    
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 70) {
                Text("Escoge la terapia que se realizará hoy")
                    .font(.custom("Sarabun", size: 30))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                    VStack {
                        Button(action: {
                            globalState.terapiaCompletaSelected.toggle()
                            globalState.terapiaSimplificadaSelected = false
                            globalState.terapiaLibreSelected = false
                        }) {
                            VStack {
                                Text("Terapia Completa")
                                    .font(.custom("Poppins", size: 25))
                                    .foregroundColor(Color.white)
                                    .padding(.vertical, 5)
                                
                                Text("Ejercicio de pinza con cada dedo y mano cerrada\n(10 repeticiones)")
                                    .font(.custom("Poppins", size: 12))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, -5)
                            }
                        }
                        .frame(width: 300, height: 100)
                        .background(globalState.terapiaCompletaSelected ? Color(#colorLiteral(red: 0.2941176471, green: 0.1333333333, blue: 0.4784313725, alpha: 1)) : Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)))
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)), lineWidth: 1))
                        
                        Spacer(minLength: 50)
                        
                        Button(action: {
                            globalState.terapiaCompletaSelected = false
                            globalState.terapiaSimplificadaSelected.toggle()
                            globalState.terapiaLibreSelected = false
                        }) {
                            VStack {
                                Text("Terapia Simplificada")
                                    .font(.custom("Poppins", size: 25))
                                    .foregroundColor(Color.white)
                                    .padding(.vertical, 5)
                                
                                Text("Ejercicio de pinza dedo índice y mano cerrada\n(10 repeticiones)")
                                    .font(.custom("Poppins", size: 12))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, -5)
                            }
                        }
                        .frame(width: 300, height: 100)
                        .background(globalState.terapiaSimplificadaSelected ? Color(#colorLiteral(red: 0.2941176471, green: 0.1333333333, blue: 0.4784313725, alpha: 1)) : Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)))
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)), lineWidth: 1))
                        
                        Spacer(minLength: 50)
                        
                        Button(action: {
                            globalState.terapiaLibreSelected.toggle()
                            globalState.terapiaCompletaSelected = false
                            globalState.terapiaSimplificadaSelected = false
                        }) {
                            VStack {
                                Text("Terapia Libre")
                                    .font(.custom("Poppins", size: 25))
                                    .foregroundColor(Color.white)
                                    .padding(.vertical, 5)
                                
                                Text("Los ejercicios se eligen libremente \n(10 repeticiones)")
                                    .font(.custom("Poppins", size: 12))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, -5)
                            }
                        }
                        .frame(width: 300, height: 100)
                        .background(globalState.terapiaLibreSelected ? Color(#colorLiteral(red: 0.2941176471, green: 0.1333333333, blue: 0.4784313725, alpha: 1)) : Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)))
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)), lineWidth: 1))
                    }
                }
                
                Button(action: {
                    if globalState.terapiaCompletaSelected {
                            let newFrequency: UInt8 = 0x01
                            module.updateFrequency(new_frequency: newFrequency)
                            self.stimParams.frequency = 0x01
                            self.navigateToNewViewCom = true
                        } else if globalState.terapiaSimplificadaSelected {
                            let newFrequency: UInt8 = 0x01
                            module.updateFrequency(new_frequency: newFrequency)
                            self.stimParams.frequency = 0x01
                            self.navigateToNewViewSim = true
                        } else if globalState.terapiaLibreSelected {
                            self.navigateToNewViewLib = true
                        }
                }) {
                    Text("Iniciar")
                        .font(.custom("Poppins", size: 25))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 5)
                }
                .frame(width: 300, height: 60)
                .background(Color(UIColor(red: 0.019, green: 0.592, blue: 0.686, alpha: 1.0)))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor(red: 0.019, green: 0.592, blue: 0.686, alpha: 1.0)), lineWidth: 1))
                
                .fullScreenCover(isPresented: $navigateToNewViewCom) {
                    IndiceCompContent(stimParams: self.$stimParams, module: module)
                }
                .fullScreenCover(isPresented: $navigateToNewViewSim) {
                    IndiceSimpContent(stimParams: self.$stimParams, module: module)
                }
                .fullScreenCover(isPresented: $navigateToNewViewLib) {
                    MenuEjercicios(stimParams: self.$stimParams, module: module)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 100)
        }
        .edgesIgnoringSafeArea(.all) // Esta línea hace que la vista esté en pantalla completa
        .frame(width: 390, height: 844)
        .background(Color.white)
        .cornerRadius(30)
    }
}

/*struct TerapiasView_Previews: PreviewProvider {
    static var previews: some View {
        TerapiasContent()
    }
}*/
