//
//  MenuEjercicios.swift
//  Rehapp
//
//  Created by Maria Velásquez Peña on 3/30/24.
//

import Foundation
import SwiftUI

func getMinValue(for frequency: Int) -> UInt8 {
    var minValue: UInt8 = 0x00
    switch frequency {
    case 1:
        minValue = 0x01
    case 2:
        minValue = 0x02
    case 3:
        minValue = 0x04
    case 4:
        minValue = 0x08
    case 5:
        minValue = 0x0A
    default:
        break
    }
    
    return minValue
}
    
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
    @Binding var stimParams: StimParameters
    @ObservedObject var module: DiscoveredPeripheral
    @EnvironmentObject var bleManager: BluetoothManager
    
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
                            Button(action: { 
                                self.navigateToIndice = true
                                let newFrequency: UInt8 = 0x01 // Definir la nueva frecuencia deseada aquí
                                    module.updateFrequency(new_frequency: newFrequency)
                                self.stimParams.frequency = 0x01
                            }) {
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
                            Button(action: { 
                                self.navigateToCorazon = true
                                let newFrequency: UInt8 = 0x02 // Definir la nueva frecuencia deseada aquí
                                    module.updateFrequency(new_frequency: newFrequency)
                                self.stimParams.frequency = 0x02
                            }) {
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
                            Button(action: {
                                self.navigateToAnular = true
                                let newFrequency: UInt8 = 0x04 // Definir la nueva frecuencia deseada aquí
                                    module.updateFrequency(new_frequency: newFrequency)
                                   self.stimParams.frequency = 0x04 // Actualizar stimParams.frequency
                            }) {
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
                            Button(action: {
                                self.navigateToMeñique = true
                                let newFrequency: UInt8 = 0x08 
                                    module.updateFrequency(new_frequency: newFrequency)
                                self.stimParams.frequency = 0x08
                            }) {
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
                        Button(action: { 
                            self.navigateToMano = true
                            let newFrequency: UInt8 = 0x0A // Definir la nueva frecuencia deseada aquí
                                module.updateFrequency(new_frequency: newFrequency)
                            self.stimParams.frequency = 0x0A
                        }) {
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
                    Button(action: {
                        isDeviceListPresented = true
                        let newFrequency: UInt8 = 0x00 // Definir la nueva frecuencia deseada aquí
                            module.updateFrequency(new_frequency: newFrequency)
                        self.stimParams.frequency = 0x00
                        bleManager.disconnectFromDevice(module: module)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor(red: 0.2941176471, green: 0.1333333333, blue: 0.4784313725, alpha: 1)))
                                .frame(width: 142, height: 43)
                            Text("Desconectar")
                                .foregroundColor(.white)
                        }
                    }
                    .fullScreenCover(isPresented: $isDeviceListPresented) {
                        DeviceList(stimParams: self.$stimParams)
                    }
                    
                    Button(action: {
                        isExerciseFinished = true
                        let newFrequency: UInt8 = 0x00 // Definir la nueva frecuencia deseada aquí
                            module.updateFrequency(new_frequency: newFrequency)
                        self.stimParams.frequency = 0x00
                    }) {
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
            .onReceive([self.stimParams.frequency].publisher.first()) { newFrequency in
                let sendingFrequency = getMinValue(for: newFrequency)
                print("Sending frequency: 0x\(String(format: "%02X", sendingFrequency))")
            }
            .padding(30)
        }
        .fullScreenCover(isPresented: $navigateToIndice) {
            IndiceLibreContent(stimParams: self.$stimParams, module: module)
        }
        .fullScreenCover(isPresented: $navigateToCorazon) {
            MedioLibreContent(stimParams: self.$stimParams, module: module)
        }
        .fullScreenCover(isPresented: $navigateToAnular) {
            AnularLibreContent(stimParams: self.$stimParams, module: module)
        }
        .fullScreenCover(isPresented: $navigateToMeñique) {
            MeniqueLibreContent(stimParams: self.$stimParams, module: module)
        }
        .fullScreenCover(isPresented: $navigateToMano) {
            ManoLibreContent(stimParams: self.$stimParams, module: module)
        }
    }
    
}

/*struct MenuEjercicios_Previews: PreviewProvider {
    static var previews: some View {
        MenuEjercicios()
    }
}*/
