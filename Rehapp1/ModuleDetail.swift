//
//  ModuleEditor.swift
//  BLEScanner
//
//  Created by Caleb Kemere on 9/23/23.
//

/*
 See the License.txt file for this sample’s licensing information.
 */


/*import SwiftUI

let LEDFrequencies = [1, 2, 4, 10]
let stimCurrents = [UInt8](0...100)
var minValue: UInt8 = 0x00

struct ModuleDetail: View {
    @Binding var stimParams: StimParameters
    @Binding var updateFreshness: UpdateFreshness
    @State var is_active = true
    @ObservedObject var bleManager: BluetoothManager
    @State private var currentSendingFrequency: UInt8 = 0x00
    
    func getMinValue(for frequency: Int) -> UInt8 {
            var minValue: UInt8 = 0x00
            switch frequency {
            case 1:
                minValue = 0x01
            case 2:
                minValue = 0x02
            case 4:
                minValue = 0x04
            case 10:
                minValue = 0x0A
            default:
                break
            }
        
        return minValue
    }
    
    var body: some View {
        VStack {
            
           HStack {
                if (!updateFreshness.led) {
                    Text(Image(systemName:"timelapse")) + Text("LED Frequency")
                        .font(.title2)
                        .foregroundColor(Color.gray)
                }
                else {
                    Text("LED Frequency")
                        .font(.title2)
                }
                
               Picker("LED Frequency", selection: $stimParams.frequency) {
                                  ForEach(LEDFrequencies, id:\.self) { frequency in
                                      Text("\(frequency) Hz")
                                  }
                              }
               
                .pickerStyle(.wheel)
                .frame(width: 150, height: 100)
                .clipped()
                .allowsHitTesting(is_active)
                
            }
            
           .onReceive([self.stimParams.frequency].publisher.first()) { newFrequency in
               let sendingFrequency = getMinValue(for: newFrequency)
               print("Sending frequency: 0x\(String(format: "%02X", sendingFrequency))")
           } //Para ver que frecuencia se esta enviando
               
            //MARK: dejo comentado para posterior implementaion en AL 2
            /*HStack {
                if (!updateFreshness.current) {
                    Text(Image(systemName:"timelapse")) + Text("Stim Current")
                        .font(.title2)
                        .foregroundColor(Color.gray)
                }
                else {
                    Text("Stim Current")
                        .font(.title2)
                }

                Picker("Stim Current", selection: $stimParams.current)
                {
                    ForEach(stimCurrents, id:\.self) {
                        Text("\(Double($0) * 2.4, specifier: "%.0f") µA") // Current bits are 2.4 uA per bit
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 150, height: 100)
                .clipped()
                .allowsHitTesting(is_active)
            }*/
        }
        
        
    }
}*/
