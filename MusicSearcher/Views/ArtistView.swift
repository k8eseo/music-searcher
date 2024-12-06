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
    
    @State private var offset: CGFloat = -1000
    @State private var statsVisible = false
    
    @AppStorage("headingColor") var headingColor: Color = Color.black
    @AppStorage("simplify") var simplify = false
    @AppStorage("largerFont") var largerFont = false
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                if let artistInfo = artistInfo {
                    
                    // Artist name
                    Text(artistInfo.name)
                        .font(.system(size: largerFont ? 45 : 40))
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        .foregroundColor(headingColor)
                        .padding(.top, 40)
                        .offset(y: offset)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1)) {
                                offset = 0
                            }
                        }
                    
                    // Listeners/playcount
                    HStack {
                        VStack {
                            if let playcount = Int(artistInfo.stats.playcount) {
                                Text(playcount.formatted(.number))
                                    .font(.system(size: largerFont ? 25 : 20))
                            }
                            
                            Text("Plays")
                                .font(.system(size: largerFont ? 15 : 12))
                        }
                        
                        Spacer()
                        
                        VStack {
                            if let listeners = Int(artistInfo.stats.listeners) {
                                Text(listeners.formatted(.number))
                                    .font(.system(size: largerFont ? 25 : 20))
                            }
                            
                            Text("Listeners")
                                .font(.system(size: largerFont ? 15 : 12))
                        }
                    }
                    .padding(.horizontal, largerFont ? 40 : 75)
                    .padding(.bottom, 30)
                    .opacity(statsVisible ? 1 : 0)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2)) {
                            statsVisible = true
                        }
                    }
                    
                    // Tags
                    if !artistInfo.tags.tag.isEmpty {
                        HStack {
                            ForEach(artistInfo.tags.tag, id: \.name) { tag in
                                Text(tag.name)
                                    .font(.system(size: largerFont ? 12 : 10))
                                    .padding(6)
                                    .background(Color.secondary.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                        .padding(.bottom, 40)
                    }
                    
                    // Biography
                    Text("Artist Biography")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(largerFont ? .title : .title2)
                        .foregroundColor(headingColor)
                    
                    if !artistInfo.bio.summary.isEmpty {
                        ScrollView {
                            Text(artistInfo.bio.summary)
                                .padding(.horizontal, 40)
                                .padding(.top, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: largerFont ? 20 : 15))
                        }
                        .frame(width: 400, height: 300)
                        .padding(.bottom, 40)
                    } else {
                        Text("No artist biography found.")
                            .padding(.top, 10)
                            .font(.system(size: largerFont ? 20 : 15))
                    }
                    
                    // Top songs
                    Text("Top Songs")
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .font(largerFont ? .title : .title2)
                        .foregroundColor(headingColor)
                    
                    ScrollView {
                        ForEach(topTracks.indices, id: \.self) { index in
                            HStack {
                                Text(topTracks[index].name)
                                    .font(largerFont ? .system(size: 20) : .body)
                                    .padding(.bottom, 3)
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    if let playcount = Int(topTracks[index].playcount) {
                                        Text("Plays: \(playcount.formatted())")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .opacity(simplify ? 0 : 1)
                                    }
                                    if let listeners = Int(topTracks[index].listeners) {
                                        Text("Listeners: \(listeners.formatted())")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .opacity(simplify ? 0 : 1)
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
                        .font(largerFont ? .title : .title2)
                        .foregroundColor(headingColor)
                    
                    if !artistInfo.similar.artist.isEmpty {
                        ForEach(artistInfo.similar.artist, id: \.name) { similarArtist in
                            Text(similarArtist.name)
                                .padding(.bottom, 5)
                                .font(.system(size: largerFont ? 20 : 15))
                        }
                    } else {
                        Text("No similar artists found.")
                            .font(.system(size: largerFont ? 20 : 15))
                    }
                }
            }
            .padding(.bottom, 50)
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

