//
//  MenuEjercicios.swift
//  Rehapp
//
//  Created by Maria Velásquez Peña on 3/30/24.
//

import Foundation
import SwiftUI

struct MenuEjercicios: View {
    @ObservedObject var globalState = GlobalState.shared
    @State private var isDeviceListPresented = false
    @State private var isExerciseFinished = false
    
    // Variables de estado para controlar la navegación a diferentes vistas
    @State private var navigateToIndice = false
    @State private var navigateToCorazon = false
    @State private var navigateToAnular = false
    @State private var navigateToMeñique = false
    @State private var navigateToMano = false
    @State private var navigateToManoLibre = false
    
    var body: some View {
        ZStack {
            Color.white
                .frame(width: 390, height: 844)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            VStack(spacing: 0) {
                
                Text("¿Qué ejercicio realizarás hoy?")
                    .font(Font.custom("Sarabun", size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.top, 67)
                
                VStack(spacing: 50) {
                    HStack(spacing: 20) {
                        VStack {
                            Button(action: { self.navigateToIndice = true }) {
                                Image("Indice")
                                    .resizable()
                                    .frame(width: 168, height: 112)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            Text("Ejercicio de pinza \n Dedo índice")
                                .font(Font.custom("Poppins", size: 13))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Button(action: { self.navigateToCorazon = true }) {
                                Image("Medio")
                                    .resizable()
                                    .frame(width: 168, height: 112)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            Text("Ejercicio de pinza \n Dedo corazón")
                                .font(Font.custom("Poppins", size: 13))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                        }
                    }
                    HStack(spacing: 20) {
                        VStack {
                            Button(action: { self.navigateToAnular = true }) {
                                Image("Anular")
                                    .resizable()
                                    .frame(width: 168, height: 112)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            Text("Ejercicio de pinza \n Dedo anular")
                                .font(Font.custom("Poppins", size: 13))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Button(action: { self.navigateToMeñique = true }) {
                                Image("Menique")
                                    .resizable()
                                    .frame(width: 168, height: 112)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            Text("Ejercicio de pinza \n Dedo meñique")
                                .font(Font.custom("Poppins", size: 13))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                        }
                    }
                    VStack {
                        Button(action: { self.navigateToMano = true }) {
                            Image("Mano")
                                .resizable()
                                .frame(width: 168, height: 112)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Text("Ejercicio mano cerrada")
                            .font(Font.custom("Poppins", size: 13))
                            .foregroundColor(Color.black)
                        
                    }
                }
                .padding(.top, 65)
                
                Spacer()
                
                HStack(spacing: 35) {
                    Button(action: {isDeviceListPresented = true}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor(red: 0.2941176471, green: 0.1333333333, blue: 0.4784313725, alpha: 1)))
                                .frame(width: 142, height: 43)
                            Text("Desconectar")
                                .foregroundColor(.white)
                        }
                    }
                    .fullScreenCover(isPresented: $isDeviceListPresented) {
                        DeviceList()
                    }
                    
                    Button(action: {isExerciseFinished = true}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor(red: 0.019, green: 0.592, blue: 0.686, alpha: 1.0)))
                                .frame(width: 142, height: 43)
                            Text("Finalizar terapia")
                                .foregroundColor(.white)
                        }
                    }
                    .fullScreenCover(isPresented: $isExerciseFinished) {
                        FelicTerContent()
                    }
                }
                .padding(.bottom, 20)
            }
            .padding(30)
        }
        .fullScreenCover(isPresented: $navigateToIndice) {
            IndiceLibreContent()
        }
        .fullScreenCover(isPresented: $navigateToCorazon) {
            MedioLibreContent()
        }
        .fullScreenCover(isPresented: $navigateToAnular) {
            AnularLibreContent()
        }
        .fullScreenCover(isPresented: $navigateToMeñique) {
            MeniqueLibreContent()
        }
        .fullScreenCover(isPresented: $navigateToMano) {
            ManoLibreContent()
        }
    }
}

struct MenuEjercicios_Previews: PreviewProvider {
    static var previews: some View {
        MenuEjercicios()
    }
}
