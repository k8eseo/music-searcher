//
//  ArtistHelper.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import Foundation

class ArtistHelper: ObservableObject {
    let fmpUrl = "http://ws.audioscrobbler.com/2.0/"
    let topTracksUrl = "?method=artist.gettoptracks&artist="
    
    private func getTopTracks(artist: String, parameters: [String:String]) -> URL? {
        var queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        guard var components = URLComponents(string: fmpUrl + topTracksUrl + artist + "&api_key=" + Keys.apikey + "&format=json") else { return nil }
        components.queryItems = queryItems
        
        return components.url
    }
    
    func fetchTopTracks(artist: String) async throws -> ArtistInfo {
        let params = ["apikey": Keys.apikey]
        
        if let url = getTopTracks(artist: artist, parameters: params) {
            let request = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw URLError.BadURL }
            
            let decoder = JSONDecoder()
            let exchange = try decoder.decode(ArtistInfo.self, from: data)
            return exchange
        }
        
        return ArtistInfo(toptracks: toptracks(track: []))
    }
}
