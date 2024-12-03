//
//  HomeView.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("music searcher")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("search by artist or album name")
            Text("trending tracks today")
                .font(.title2)
                .padding(.top)
                .fontWeight(.bold)
            Text("have list of trending tracks below using api")
        }
    }
}

#Preview {
    HomeView()
}
