//
//  ModuleControl.swift
//  BLEScanner
//
//  Created by Caleb Kemere on 9/21/23.
//

/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct ModuleControl: View {
    @ObservedObject var module: DiscoveredPeripheral
    @EnvironmentObject var bleManager: BluetoothManager
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var newStimParams:StimParameters = StimParameters()
        
    @State private var parametersChanged = false
    
    @State private var is_editing = false
    
    var body: some View {
        List {
            if (module.connectionState != ConnectionState.connected) {
                switch module.connectionState {
                case ConnectionState.not_connected:
                    Text("No conectado")
                case ConnectionState.disconnected:
                    Text("No conectado (desconectado)")
                case ConnectionState.waiting_for_connection:
                    Text("Esperando conexión")
                case ConnectionState.connected:
                    Text("Conectado")
                }}
            else {
                switch module.scanningState {
                case ScanningState.not_connected:
                    Text("No escaneado (No conectado)")
                case ScanningState.retrieving_services:
                    Text("[Conectado] Buscando servicios")
                case ScanningState.querying_characteristics:
                    Text("[Conectado] Consultando características")
                case ScanningState.retrieving_characteristics:
                    Text("[Conectado] Buscando características")
                case ScanningState.module_updated:
                    Text("[Conectado] Datos del módulo cargados")
                }
            }

            HStack{
                Button(action: {
                    bleManager.connectToDevice(module: module)
                })
                {
                    Text("Conectar al módulo")
                }
                Button(action: {
                    module.requery_module()
                })
                {
                    Text("Releer datos del módulo")
                }
                Button(action: {
                    bleManager.disconnectFromDevice(module: module)
               })
               {
                   Text("Desconectar módulo")
              }
            }
            
            VStack(alignment: .leading) {
                Text(module.peripheral.name ?? "Dispositivo desconocido")
                    .font(.title2)
                    .fontWeight(.semibold)
                    
                if is_editing {
                    ModuleDetail(stimParams: $newStimParams, updateFreshness: Binding(
                        get: { module.updateFreshness },
                        set: { module.updateFreshness = $0 }
                    ), bleManager: bleManager)
                    .onAppear {
                        newStimParams = module.stimParameters // Copy details to edit
                    }
                } else {
                    ModuleDetail(stimParams: $module.stimParameters, updateFreshness: Binding(
                        get: { module.updateFreshness },
                        set: { module.updateFreshness = $0 }
                    ), is_active: false, bleManager: bleManager)
                }



                HStack {
                    Button(action: {
                        if (!is_editing) {
                            is_editing = true
                        }
                        else
                        {
                            newStimParams = module.stimParameters // Reset values
                            is_editing = false
                        }
                    }){
                        if (!is_editing) {
                            Label("Lock", systemImage: "lock").labelStyle(.iconOnly).font(.title)

                        }
                        else {
                            Label("Unlock", systemImage: "lock.open").labelStyle(.iconOnly).font(.title)
                        }
                    }
                    .background(Color.white)
                    .foregroundColor(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))


                    Button(action: {
                        if (module.stimParameters.frequency != newStimParams.frequency) {
                            if let newFrequency = UInt8(exactly: newStimParams.frequency) {
                                module.updateFrequency(new_frequency: newFrequency)
                            } else {
                                print("Error: Could not convert \(newStimParams.frequency) to UInt8")
                            }
                        } else if (module.stimParameters.current != newStimParams.current) {
                            module.updateCurrent(new_current: newStimParams.current)
                        }
                        module.stimParameters = newStimParams // Update module values
                    })
{
                        Label("Update", systemImage: "arrow.up").labelStyle(.iconOnly).font(.title)
                    }
                    .accentColor(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(!is_editing || (module.stimParameters == newStimParams))

                    Button(action: {
                        newStimParams = module.stimParameters // Reset values
                    }) {
                        Label("Undo", systemImage: "arrow.uturn.backward").labelStyle(.iconOnly).font(.title)
                    }
                    .accentColor(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(!is_editing || (module.stimParameters == newStimParams))
                }
                .buttonStyle(.bordered)

            }
        }
        .environmentObject(bleManager)
    }
}
