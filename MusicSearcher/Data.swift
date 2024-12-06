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

// Artist info
struct ArtistResponse: Codable {
    let artist: ArtistInfo
}

struct ArtistInfo: Codable {
    let name: String
    let stats: ArtistStats
    let similar: SimilarArtists
    let tags: ArtistTags
    let bio: ArtistBio
}

struct ArtistStats: Codable {
    let listeners: String
    let playcount: String
}

struct SimilarArtists: Codable {
    let artist: [TrackArtistInfo]
}

struct ArtistTags: Codable {
    let tag: [Tag]
}

struct Tag: Codable {
    let name: String
}

struct ArtistBio: Codable {
    let summary: String
}

// Track info
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
