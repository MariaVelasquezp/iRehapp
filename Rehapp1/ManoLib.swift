//
//  ManoLib.swift
//  Rehapp
//
//  Created by Maria Velásquez Peña on 4/27/24.
//

import Foundation
import SwiftUI
import AVKit

struct ManoLibreContent: View {
    @State private var isExerciseFinished = false
    @State private var isTextVisible = true
    @State private var isBackgroundWhite = true
    @State private var player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "MANOCERRADA", ofType: "mp4")!))
    
    var body: some View {
        ZStack {
            Color(isBackgroundWhite ? .white : .black)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                VStack(spacing: 70) {
                    VStack {
                        if isTextVisible {
                            Text("Ejercicio \n Mano cerrada")
                                .font(.custom("Sarabun", size: 30))
                                .foregroundColor(Color.black)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top, 100)
                        }
                    }
                    .transition(.opacity) // Agregar transición de opacidad al texto
                    
                    VideoPlayer(player: player)
                        .frame(width: 330, height: 185)
                        .cornerRadius(10)
                        .padding(.top, isBackgroundWhite ? 70 : 200) // Ajustar la posición del video
                        .padding(.bottom, isBackgroundWhite ? 0 : 70) // Ajustar la posición del video
                        .onTapGesture {
                            withAnimation {
                                isTextVisible.toggle()
                                isBackgroundWhite.toggle()
                            }
                        }
                        .onDisappear {
                            player.pause()
                        }
                        .onAppear {
                            // Observar el momento en que el video llega al final
                            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                                // Reiniciar la reproducción cuando llega al final
                                self.player.seek(to: .zero)
                                self.player.play()
                            }
                        }
                    
                    VStack {
                        if isTextVisible {
                            Text("Toca sobre el video guía \n para activar el modo enfoque")
                                .font(.custom("Sarabun", size: 20))
                                .foregroundColor(Color(UIColor(red: 0.2941176471, green: 0.1333333333, blue: 0.4784313725, alpha: 1)))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top, -30)
                        }
                    }
                    .transition(.opacity) // Agregar transición de opacidad al texto
                    
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
                        .padding(.top, -40)
                        
                        Spacer()
                        
                        Button(action: {
                            isExerciseFinished = true
                        }) {
                            Text("Menú ejercicios")
                                .font(.custom("Sarabun", size: 16))
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .frame(width: 142, height: 43)
                                .background(Color(UIColor(red: 0.019, green: 0.592, blue: 0.686, alpha: 1.0)))
                                .cornerRadius(10)
                        }
                        .fullScreenCover(isPresented: $isExerciseFinished) {
                       //     MenuEjercicios()
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal, 30)
                }
                .frame(width: 390, height: 844)
                .background(Color.clear)
                .cornerRadius(30)
            }
        }
        .onAppear {
            player.play()
        }
    }
}

struct ManoLibreView_Previews: PreviewProvider {
    static var previews: some View {
        ManoLibreContent()
    }
}
