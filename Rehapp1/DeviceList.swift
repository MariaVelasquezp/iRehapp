//
//  DeviceList.swift
//
//  From BLESCanner, Created by Christian Möller on 02.01.23.
//

import SwiftUI
import CoreBluetooth


func calculateBars(rssi: Int) -> Int {
    switch rssi {
    case -39..<Int.max:
        return 5
    case -49..<(-39):
        return 4
    case -59..<(-49):
        return 3
    case -69..<(-59):
        return 2
    case -79..<(-69):
        return 1
    default:
        return 0
    }
}

struct SignalStrengthIndicator: View {
// from https://www.objc.io/blog/2020/02/18/a-signal-strength-indicator/
    var rssi:Int = -100
    var body: some View {
        HStack {
            ForEach(0..<5) { bar in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.primary.opacity(bar < calculateBars(rssi: self.rssi) ? 1 : 0.3))
            }
        }
    }
}

struct DeviceList: View {
    @StateObject var bleManager = BluetoothManager()
    @State private var isTerapiasContentPresented = false

    var body: some View {
        VStack {
            NavigationView {
                // List of discovered peripherals
                List(bleManager.discoveredPeripherals, id: \.peripheral.identifier) { module in
                    HStack {
                        Text("Ampfreq")
                            .fontWeight(.bold)
                            .frame(width: 225, alignment: .leading)
                            .font(.title2)
                        VStack {
                            SignalStrengthIndicator(rssi: module.rssi)
                            Text("\(module.rssi)dB").font(.subheadline)
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isTerapiasContentPresented = true
                    }
                }
                .navigationTitle("Módulos descubiertos")
            }
            .environmentObject(bleManager)

            // Button for starting or stopping scanning
            Button(action: {
                if self.bleManager.isScanning {
                    self.bleManager.stopScan()
                } else {
                    self.bleManager.startScan()
                }
            }) {
                if bleManager.isScanning {
                    Text("Dejar de escanear")
                } else {
                    Text("Escanear dispositivos")
                }
            }
            // Button looks cooler this way on iOS
            .padding()
            .background(bleManager.isScanning ? Color.red : Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
        }
        .fullScreenCover(isPresented: $isTerapiasContentPresented) {
            TerapiasContent()
        }
    }
}

struct DeviceList_Previews: PreviewProvider {
    static var previews: some View {
        DeviceList()
    }
}
