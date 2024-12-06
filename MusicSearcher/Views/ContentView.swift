//
//  ContentView.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("colorScheme") var colorScheme = 0
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label(LocalizedStringKey(TabType.home.title), systemImage: "house.fill")
                }
                .tag(0)
            
            SearchArtistView(artistName: "")
                .tabItem {
                    Label(LocalizedStringKey(TabType.search.title), systemImage: "magnifyingglass")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label(LocalizedStringKey(TabType.settings.title), systemImage: "gearshape.fill")
                }
                .tag(2)
            
            InfoView()
                .tabItem {
                    Label(LocalizedStringKey(TabType.info.title), systemImage: "info")
                }
                .tag(2)
        }
        .preferredColorScheme(colorScheme == 1 ? .light : colorScheme == 2 ? .dark : nil)
    }
}

#Preview {
    ContentView()
}
