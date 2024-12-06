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
    
    @State private var artistInfo: ArtistInfo? = nil
    @State private var topTracks: [TrackInfo] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                if let artistInfo = artistInfo {
                    
                    // Artist name
                    Text(artistInfo.name)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    // Listeners/playcount
                    HStack {
                        VStack {
                            if let playcount = Int(artistInfo.stats.playcount) {
                                Text(playcount.formatted(.number))
                                    .font(.system(size: 20))
                            }
                            
                            Text("Plays")
                                .font(.system(size: 12))
                        }
                        
                        Spacer()
                        
                        VStack {
                            if let listeners = Int(artistInfo.stats.listeners) {
                                Text(listeners.formatted(.number))
                                    .font(.system(size: 20))
                            }
                            
                            Text("Listeners")
                                .font(.system(size: 12))
                        }
                    }
                    .padding(.horizontal, 75)
                    .padding(.bottom, 20)
                    
                    // Tags
                    if !artistInfo.tags.tag.isEmpty {
                        HStack {
                            ForEach(artistInfo.tags.tag, id: \.name) { tag in
                                Text(tag.name)
                                    .font(.system(size: 10))
                                    .padding(6)
                                    .background(Color.secondary.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    
                    // Biography
                    Text("Artist Biography")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title2)
                    
                    ScrollView {
                        Text(artistInfo.bio.summary)
                            .padding(.horizontal, 40)
                            .padding(.top, 25)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 15))
                    }
                    .frame(width: 400, height: 300)
                    .padding(.bottom, 40)
                    
                    // Top songs
                    Text("Top Songs")
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .font(.title2)
                    
                    ScrollView {
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
                        .listStyle(PlainListStyle())
                        .padding(.bottom, 50)
                    }
                    
                    // Similar artists
                    Text("Similar Artists")
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .font(.title2)
                    
                    ForEach(artistInfo.similar.artist, id: \.name) { similarArtist in
                        Text(similarArtist.name)
                            .padding(.bottom, 5)
                }
                }
            }
        }
        
        .task {
            await loadArtistInfo()
        }
    }
    
    private func loadArtistInfo() async {
        do {
            let info = try await artistHelper.fetchArtistInfo(artist: artistName)
            let tracks = try await artistHelper.fetchArtistTracks(artist: artistName)
            artistInfo = info
            topTracks = tracks
            isLoading = false
        } catch {
            errorMessage = "Failed to fetch artist info. Please try again."
            isLoading = false
        }
    }
}

#Preview {
    ArtistView(artistName: "Frank Ocean")
        .environmentObject(APIHelper())
}

