//
//  Data.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/4/24.
//

import Foundation

// Top tracks on the charts
struct ChartsTracksResponse: Codable {
    let tracks: Tracks
}

// Top songs of artist
struct TopTracksResponse: Codable {
    let toptracks: Tracks
}

// Track
struct Tracks: Codable {
    let track: [TrackInfo]
}

struct TrackInfo: Codable {
    let name: String
    let playcount: String
    let listeners: String
    let artist: TrackArtistInfo
}

struct TrackArtistInfo: Codable {
    let name: String
}
