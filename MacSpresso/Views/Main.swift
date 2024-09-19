//
//  Main.swift
//  MacSpresso
//
//  Created by 6b70 on 9/8/24.
//

import SwiftUI

struct Main: View {
    var delegate: AppDelegate = NSApp.delegate as! AppDelegate
    
    @ObservedObject var settings = AppSettings.shared
    @ObservedObject var manager = CaffeinateManager.shared
    
    @State private var currentPage = 0
    
    var body: some View {
        PagerView(pageCount: 2, currentIndex: $currentPage) {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Text("MacSpresso")
                    .help(Text("MacSpresso Menu Bar App"))
                    .font(Font.system(size:30, design: .monospaced))
                    .padding(.bottom, 50)
                Button(action: {
                    delegate.quit()
                }) {
                    HStack {
                        Image(systemName: "cup.and.saucer")
                        Text("Decaffeinate")
                            .font(Font.system(size:15, design: .monospaced))
                    }
                    .padding()
                    .cornerRadius(10)
                }
                .help(Text("Stops caffeination"))
                .buttonStyle(.bordered)
                .padding(.bottom, 20)
                
                Text("Caffeinated for \(formatElapsedTime(seconds: manager.elapsedTime))")
                HStack {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .padding(.bottom, 20)
                .contentShape(Rectangle())
                .help(Text("App Settings"))
                .accessibility(hint: Text("On click navigates to settings section"))
                .onTapGesture {
                    withAnimation {
                        currentPage = 1
                    }
                }
            }
            
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                
                Toggle("Prevent Display Sleep", isOn: $settings.preventDisplaySleep)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                
                Toggle("Prevent System Sleep", isOn: $settings.preventSystemSleep)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                
                Toggle("Prevent Disk Sleep", isOn: $settings.preventDiskSleep)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                
                Spacer()
                HStack(alignment: .center, spacing: 30) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                        Text("Back")
                    }
                    .contentShape(Rectangle())
                    .help(Text("Return Main View"))
                    .accessibility(hint: Text("On click navigates to main section"))
                    .onTapGesture {
                        withAnimation {
                            currentPage = 0
                        }
                    }
                    
                    HStack {
                        Image(systemName: "power")
                        Text("Quit App")
                    }
                    .contentShape(Rectangle())
                    .help(Text("Return Main View"))
                    .accessibility(hint: Text("On click navigates to main section"))
                    .onTapGesture {
                        delegate.quit()
                    }
                }.padding(.bottom, 20)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
    
}

func formatElapsedTime(seconds: Int) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .short
    
    return formatter.string(from: TimeInterval(seconds)) ?? "0:00:00"
}
