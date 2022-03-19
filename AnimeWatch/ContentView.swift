//
//  ContentView.swift
//  AnimeWatch
//
//  Created by Andrea on 14/03/22.
//

import SwiftUI

struct ContentView: View {
    let popularAnime = PopularAnimeScreen()
    let reccomendationsAnime = DiscoverScreen()
    var body: some View {
        VStack {
            popularAnime
            reccomendationsAnime
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
