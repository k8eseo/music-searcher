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
        VStack {
            Text("Music Searcher")
                .font(.title)
                .fontWeight(.bold)
            Text("Search by artist or album name")
            Text("Trending tracks today")
                .font(.title2)
                .padding(.top)
                .fontWeight(.bold)
            
            // Display the list of trending tracks
            List(trendingTracks, id: \.name) { track in
                VStack(alignment: .leading) {
                    Text(track.name)
                        .font(.headline)
                    Text("Artist: \(track.artist.name)")
                        .font(.subheadline)
                    Text("Playcount: \(track.playcount) | Listeners: \(track.listeners)")
                        .font(.subheadline)
                }
                .padding(.vertical, 4)
            }
            .onAppear {
                // Fetch the trending tracks when the view appears
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

#Preview {
    HomeView()
}
