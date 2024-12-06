//
//  SettingsView.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/5/24.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("colorScheme") var colorScheme = 0
    @AppStorage("headingColor") var headingColor: Color = Color.black
    @AppStorage("largerFont") var largerFont = false
    @AppStorage("simplify") var simplify = false
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                Section("Appearance") {
                    Picker(selection: $colorScheme, label: Text("Appearance")) {
                        Text("System").tag(0)
                        Text("Light").tag(1)
                        Text("Dark").tag(2)
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Heading Color") {
                    ColorPicker("Color", selection: $headingColor)
                }
                
                Section("Larger Font") {
                    Toggle("Larger Font", isOn: $largerFont)
                }
                
                Section("Simplify") {
                    Toggle("Simplify Details", isOn: $simplify)
                }
                
                
            }
            .navigationTitle("Settings")
                
        }
    }
}

#Preview {
    SettingsView()
}
