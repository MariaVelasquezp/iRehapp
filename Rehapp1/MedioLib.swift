//
//  MedioLib.swift
//  Rehapp
//
//  Created by Maria Velásquez Peña on 4/27/24.
//

import Foundation
import SwiftUI
import AVKit

struct MedioLibreContent: View {
    @ObservedObject var globalState = GlobalState.shared
    @State private var isExerciseFinished = false
    @State private var player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "CORAZON", ofType: "mp4")!))
    
    var body: some View {
        VStack(spacing: 0) {
            
            VStack(spacing: 70) {
                
                VStack {
                    Text("Ejercicio de pinza \n Dedo corazón")
                        .font(.custom("Sarabun", size: 30))
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 100)
                }
                
                VideoPlayer(player: player)
                    .frame(width: 330, height: 185)
                    .cornerRadius(10)
                    .padding(.top, 70)
                    .onDisappear {
                        player.pause()
                    }
                
                Text("Toca sobre la imagen para \n reproducir el video guía")
                    .font(.custom("Sarabun", size: 20))
                    .foregroundColor(Color(UIColor(red: 0.2941176471, green: 0.1333333333, blue: 0.4784313725, alpha: 1)))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, -30)
                
                Spacer()
                
                HStack(spacing: 0) {
                    Button(action: {
                        // Acción al detener
                    }) {
                        Text("Detener")
                            .font(.custom("Sarabun", size: 20))
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .frame(width: 142, height: 43)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.top, -40) // Ajuste de la posición vertical
                    
                    Spacer()
                    
                    Button(action: {
                        isExerciseFinished = true
                    }) {
                        Text("Siguiente ejercicio")
                            .font(.custom("Sarabun", size: 16))
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .frame(width: 142, height: 43)
                            .background(Color(UIColor(red: 0.019, green: 0.592, blue: 0.686, alpha: 1.0)))
                            .cornerRadius(10)
                    }
                    .fullScreenCover(isPresented: $isExerciseFinished) {
                        MenuEjercicios()
                    }
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 30)
            }
            .frame(width: 390, height: 844)
            .background(Color.white)
            .cornerRadius(30)
        }
    }
}


struct MedioLibreContentView_Previews: PreviewProvider {
    static var previews: some View {
        MedioLibreContent()
    }
}
