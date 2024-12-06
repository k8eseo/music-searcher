//
//  ContentView.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(TabType.home.title, systemImage: "house.fill")
                }
                .tag(0)
            
            SearchArtistView(artistName: "")
                .tabItem {
                    Label(TabType.search.title, systemImage: "magnifyingglass")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
