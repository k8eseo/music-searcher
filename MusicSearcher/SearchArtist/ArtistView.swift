//
//  ArtistView.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import SwiftUI

struct ArtistView: View {
    @EnvironmentObject private var artistHelper: APIHelper
    let artistName: String
    
    @State private var topTracks: [TrackInfo] = []
    @State private var fetchedArtistName: String? = nil
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
            }
            else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            else {
                if let fetchedArtistName = fetchedArtistName {
                    Text(fetchedArtistName)
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()
                }
                Text("Top Songs")
                List(topTracks.indices, id: \.self) { index in
                    HStack {
                        Text(topTracks[index].name)
                            .font(.body)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .task {
            await fetchTracks()
        }
    }
    
    private func fetchTracks() async {
        do {
            let tracks = try await artistHelper.fetchArtistTracks(artist: artistName)
            topTracks = tracks
            fetchedArtistName = tracks.first?.artist.name
            isLoading = false
        } catch {
            errorMessage = "Error. Please try again."
            isLoading = false
        }
    }
}

#Preview {
    ArtistView(artistName: "Frank ocean")
        .environmentObject(APIHelper())
}
