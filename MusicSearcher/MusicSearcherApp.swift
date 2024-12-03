//
//  MusicSearcherApp.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import SwiftUI

enum URLError: Error {
    case BadURL, BadData
}

@main
struct MusicSearcherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ArtistHelper())
        }
    }
}
