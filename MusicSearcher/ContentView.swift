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
                    Label(TabType.home.title, image: TabType.home.image)
                }
                .tag(0)
            
            SearchArtistView()
                .tabItem {
                    Label(TabType.artist.title, image: TabType.artist.image)
                }
                .tag(1)
            
            SearchAlbumView()
                .tabItem {
                    Label(TabType.album.title, image: TabType.album.image)
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
