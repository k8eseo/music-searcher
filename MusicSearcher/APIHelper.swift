//
//  APIHelper.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/4/24.
//

import Foundation

class APIHelper: ObservableObject {
    let baseUrl = "https://ws.audioscrobbler.com/2.0/"
    let apiKey = Keys.apikey

    private func buildUrl(endpoint: String, parameters: [String: String]) -> URL? {
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        queryItems.append(URLQueryItem(name: "format", value: "json"))
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        var components = URLComponents(string: baseUrl + endpoint)
        components?.queryItems = queryItems
        
        return components?.url
    }

    // Fetch top songs on charts
    func fetchTrendingTracks() async throws -> [TrackInfo] {
        let params = ["method": "chart.gettoptracks"]
        guard let url = buildUrl(endpoint: "?method=chart.gettoptracks&api_key=" + Keys.apikey + "&format=json", parameters: params) else {
            throw URLError.BadURL
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        let decodedResponse = try decoder.decode(ChartsTracksResponse.self, from: data)
        
        return Array(decodedResponse.tracks.track.prefix(50))
    }
    
    // Method for fetching artist's top tracks
    func fetchArtistTracks(artist: String) async throws -> [TrackInfo] {
        let params = ["method": "artist.gettoptracks", "artist": artist]
        guard let url = buildUrl(endpoint: "?method=artist.gettoptracks&artist=" + artist + "&api_key=" + Keys.apikey + "&format=json", parameters: params) else {
            throw URLError.BadURL
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        let decodedResponse = try decoder.decode(TopTracksResponse.self, from: data)
        
        return Array(decodedResponse.toptracks.track.prefix(15))
    }
}

