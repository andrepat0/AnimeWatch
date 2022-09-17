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
                //RecentlyReleasedScreen()
                VStack(spacing: 15){
                    PopularAnimeScreen()
                    AnimeRecommendationsScreen()
                    GenreScreen()
                    UpcomingAnimeScreen()
                }
                .accentColor(/*@START_MENU_TOKEN@*/Color("white")/*@END_MENU_TOKEN@*/)
                .padding(.leading, 15)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
