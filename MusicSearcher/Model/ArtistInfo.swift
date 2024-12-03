//
//  ArtistInfo.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import Foundation

struct ArtistInfo: Codable {
    let toptracks: toptracks
}

struct toptracks: Codable {
    let track: [track]
}

struct track: Codable {
    let name: String
    let playcount: Int
}
