//
//  Rehapp1App.swift
//  Rehapp1
//
//  Created by Maria Velásquez Peña on 1/17/24.
//

import SwiftUI
@main
struct Rehapp1App: App {
    @State var stimParams = StimParameters() // Declaración de stimParams como State
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainEntrance(stimParams: $stimParams) // Pasando stimParams a MainEntrance
            }
        }
    }
}
