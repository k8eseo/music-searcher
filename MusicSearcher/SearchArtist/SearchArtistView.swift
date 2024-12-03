//
//  SearchArtistView.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import SwiftUI

struct SearchArtistView: View {
    
    @State var artistName: String = ""
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            Text("top tracks")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.bottom)
            HStack {
                TextField("artist name", text: $artistName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        if let doIt = action { doIt() }
                    }
                Button {
                    if let doIt = action { doIt() }
                } label: {
                    Label("", systemImage: "magnifyingglass")
                }
                .disabled(artistName.isEmpty)
            }
        }
    }
}

#Preview {
    SearchArtistView(artistName: "")
}
