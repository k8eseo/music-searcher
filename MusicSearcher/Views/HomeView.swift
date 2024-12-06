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
    
    @AppStorage("headingColor") var headingColor: Color = Color.black
    @AppStorage("simplify") var simplify = false
    @AppStorage("largerFont") var largerFont = false
    
    @State private var showingOptions = false
    @State private var selection = 10

    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Music Searcher")
                    .font(.system(size: (largerFont ? 45 : 40)))
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    .foregroundColor(headingColor)
                
                Text("Search artists and songs")
                    .font(.system(size: (largerFont ? 25 : 15)))
                    .padding(.bottom, 50)
                
                Text("Trending Tracks Today")
                    .font(largerFont ? .system(size: 30) : .title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                    .foregroundColor(headingColor)
                
                Button("Number of Results") {
                    showingOptions = true
                }
                .confirmationDialog("Pick a number", isPresented: $showingOptions, titleVisibility: .visible) {
                    ForEach([10, 25, 50, 100], id: \.self) { num in
                        Button("\(num)") {
                            selection = num
                            fetchTrendingTracks()
                        }
                    }
                }
                .background(headingColor)
                .foregroundColor(.white)
                .font(.system(size: largerFont ? 15 : 13))
                .cornerRadius(5)
                .padding(.bottom, 10)
                
                // Refresh button
                Button(action: { fetchTrendingTracks() }) {
                    HStack {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.system(size: 20))
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                }
                
                List(trendingTracks, id: \.name) { track in
                    
                    NavigationLink(destination: ArtistView(artistName: track.artist.name)) {
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(track.name)
                                    .font(largerFont ? .system(size: 20) : .body)
                                    .padding(.bottom, 3)
                                
                                Text(track.artist.name)
                                    .font(.system(size: largerFont ? 15 : 12))
                                    .foregroundColor(Color("AccentColor"))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                if let playcount = Int(track.playcount) {
                                    Text("Plays: \(playcount.formatted())")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .opacity(simplify ? 0 : 1)
                                }
                                if let listeners = Int(track.listeners) {
                                    Text("Listeners: \(listeners.formatted())")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .opacity(simplify ? 0 : 1)
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    fetchTrendingTracks()
                }
            }
            .padding()
        }
    }
    
    private func fetchTrendingTracks() {
        Task {
            do {
                trendingTracks = try await homeHelper.fetchTrendingTracks(limit: selection)
            } catch {
                print("Error fetching trending tracks: \(error)")
            }
        }
    }
}

#Preview {
    HomeView()
}




