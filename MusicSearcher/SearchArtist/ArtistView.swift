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
    @State private var artistBio: String?

    var body: some View {
        ScrollView {
            VStack {
                if let fetchedArtistName = fetchedArtistName {
                    Text(fetchedArtistName)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                }
                
                Text("Artist Biography")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title2)
                
                if let bio = artistBio {
                    ScrollView {
                        Text(bio)
                            .padding(.horizontal, 40)
                            .padding(.top, 25)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 15))
                    }
                    .frame(width: 400, height: 300)
                    .padding(.bottom, 40)
                }
                
                Text("Top Songs")
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                    .font(.title2)
                LazyVStack {
                    ForEach(topTracks.indices, id: \.self) { index in
                        HStack {
                            Text(topTracks[index].name)
                                .font(.body)
                                .padding(.bottom, 3)
                            Spacer()
                            VStack(alignment: .trailing) {
                                if let playcount = Int(topTracks[index].playcount) {
                                    Text("Plays: \(playcount.formatted())")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                if let listeners = Int(topTracks[index].listeners) {
                                    Text("Listeners: \(listeners.formatted())")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.bottom, 50)
            }
        }

        .task {
            await fetchBio()
            await fetchTracks() // Keeps the song-fetching logic unchanged
        }
    }
    
    private func fetchBio() async {
        do {
            let artistInfo = try await artistHelper.fetchArtistInfo(artist: artistName)
            artistBio = artistInfo.bio.summary
        } catch {
            errorMessage = "Error fetching bio. Please try again."
            artistBio = nil
        }
    }
    
    private func fetchTracks() async {
        do {
            let tracks = try await artistHelper.fetchArtistTracks(artist: artistName)
            topTracks = tracks
            fetchedArtistName = tracks.first?.artist.name
            isLoading = false
        } catch {
            errorMessage = "Error fetching tracks. Please try again."
            isLoading = false
        }
    }
}

#Preview {
    ArtistView(artistName: "Frank Ocean")
        .environmentObject(APIHelper())
}

