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
                VStack{
                    HStack{
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .cornerRadius(50)
                        Spacer()
                    }.padding([.leading, .bottom])
                   // PopularAnimeScreen()
                    DiscoverScreen()
                }
                .accentColor(/*@START_MENU_TOKEN@*/Color("white")/*@END_MENU_TOKEN@*/)
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
