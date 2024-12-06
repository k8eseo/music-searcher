//
//  HomeView.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeHelper = APIHelper()
    @State private var trendingTracks: [TrackInfo] = []

    var body: some View {
        NavigationView {
            
            VStack {
                
                Text("Music Searcher")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.top, 30)
                
                Text("Search artists and songs")
                    .font(.system(size: 15))
                    .padding(.bottom, 50)
                
                Text("Trending Tracks Today")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                List(trendingTracks, id: \.name) { track in
                    
                    NavigationLink(destination: ArtistView(artistName: track.artist.name)) {
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(track.name)
                                    .font(.body)
                                    .padding(.bottom, 3)
                                
                                    Text(track.artist.name)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color("AccentColor"))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                if let playcount = Int(track.playcount) {
                                    Text("Plays: \(playcount.formatted())")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                if let listeners = Int(track.listeners) {
                                    Text("Listeners: \(listeners.formatted())")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    Task {
                        do {
                            trendingTracks = try await homeHelper.fetchTrendingTracks()
                        } catch {
                            print("Error fetching trending tracks: \(error)")
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}


