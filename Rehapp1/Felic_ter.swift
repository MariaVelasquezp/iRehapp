//
//  Felic_ter.swift
//  Rehapp
//
//  Created by Maria Velásquez Peña on 4/1/24.
//

import Foundation
import SwiftUI

struct FelicTerContent: View {
    @ObservedObject var globalState = GlobalState.shared
    @State private var navigateToTerapias = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 70) {
                Image("Image")
                    .resizable()
                    .frame(width: 258, height: 258)
                    .padding(.top, 100)
                
                Text("¡Has finalizado la terapia!")
                    .font(.custom("Sarabun", size: 40))
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                Button(action: {
                    // Reiniciar las banderas
                    globalState.terapiaCompletaSelected = false
                    globalState.terapiaSimplificadaSelected = false
                    globalState.terapiaLibreSelected = false
                    
                    // Mostrar la vista TerapiasContent
                    navigateToTerapias = true
                }) {
                    Text("Volver")
                        .font(.custom("Sarabun", size: 25))
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .frame(width: 330, height: 62)
                        .background(Color(UIColor(red: 0.019, green: 0.592, blue: 0.686, alpha: 1.0)))
                        .cornerRadius(20)
                }
                .padding(.bottom, 100)
                .fullScreenCover(isPresented: $navigateToTerapias) {
                    //TerapiasContent()
                }
            }
            .padding(.horizontal, 30)
        }
        .frame(width: 390, height: 844)
        .background(Color.white)
        .cornerRadius(30)
    }
}



struct FelicTerView_Previews: PreviewProvider {
    static var previews: some View {
        FelicTerContent()
    }
}
