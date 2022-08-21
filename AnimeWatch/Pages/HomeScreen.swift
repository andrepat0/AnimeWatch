//
//  HomeScreen.swift
//  AnimeWatch
//
//  Created by Andrea on 25/04/22.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 15){
                    PopularAnimeScreen()
                    AnimeRecommendationsScreen()
                    GenreScreen()
                }
                .accentColor(/*@START_MENU_TOKEN@*/Color("white")/*@END_MENU_TOKEN@*/)
                .padding(.leading, 15)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
