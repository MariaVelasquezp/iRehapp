//
//  Main_entrance.swift
//  Rehapp
//
//  Created by Maria Velásquez Peña on 3/27/24.
//

import UIKit
import SwiftUI

struct MainEntrance: View {
    @ObservedObject var globalState = GlobalState.shared
    @Binding var stimParams: StimParameters
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            CustomView(stimParams: $stimParams)
        }
    }
}

struct CustomView: View {
    @State private var isDeviceListPresented = false
    @Binding var stimParams: StimParameters
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 16) {
                Text("iRehapp")
                    .font(.custom("Sarabun", size: 70))
                    .foregroundColor(Color(red: 0.019, green: 0.592, blue: 0.686))
                    .padding(.leading, 30)
                    .offset(x: -60, y: -130)
                
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 350)
                    .offset(x: 0, y: -60)
                
                Button(action: {
                    isDeviceListPresented = true
                }) {
                    Text("Comenzar")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 330, height: 63)
                        .background(Color(red: 0.019, green: 0.592, blue: 0.686))
                        .cornerRadius(20)
                }
                .offset(x: 0, y: 30)
                .fullScreenCover(isPresented: $isDeviceListPresented) {
                    DeviceList(stimParams: $stimParams)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 100)
        }
        .frame(width: 390, height: 844)
        .background(Color.white)
        .cornerRadius(30)
    }
}

/*struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView()
    }
}*/
