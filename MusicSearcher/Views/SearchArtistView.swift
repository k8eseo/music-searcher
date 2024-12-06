//
//  SearchArtistView.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import SwiftUI

struct SearchArtistView: View {
    @State var artistName: String
    @State private var navigateToNextView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Search by Artist Name")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                HStack {
                    TextField("Artist Name", text: $artistName)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 250)
                        .textInputAutocapitalization(.never)
                        .onSubmit {
                            navigateToNextView = !artistName.isEmpty
                        }
                    
                    Button {
                        navigateToNextView = !artistName.isEmpty
                    } label: {
                        Label("", systemImage: "magnifyingglass")
                    }
                    .disabled(artistName.isEmpty)
                }
                
                NavigationLink(
                    destination: ArtistView(artistName: artistName).environmentObject(APIHelper()),
                    isActive: $navigateToNextView,
                    label: { EmptyView() }
                )
            }
            .padding()
        }
    }
}

#Preview {
    SearchArtistView(artistName: "")
}
