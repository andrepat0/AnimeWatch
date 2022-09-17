//
//  UpcomingAnimeScreen.swift
//  AnimeWatch
//
//  Created by Andrea on 17/09/22.
//

import SwiftUI

struct UpcomingAnimeScreen: View {
    @State private var index = 0
    @StateObject private var vm = UpcomingAnimeDataSource()
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                
                Text("Upcoming")
                    .foregroundColor(Color("white"))
                    .font(.custom(FontsManager.Montserrat.bold, size: 22))
                    .fontWeight(.medium)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack{
                    ForEach(vm.upcomingAnime, id: \.id) { anime in
                        VStack(alignment: .leading){
                            ZStack{
                                if((anime.attributes.posterImage.small) != nil){
                                    AsyncImage(url: URL(string: anime.attributes.posterImage.small ?? "")!, placeholder: {
                                        Color.black
                                    }, image: {image in Image(uiImage: image).resizable()})
                                }else{
                                    RoundedRectangle(cornerRadius: 10)
                                }
                                
                            }.frame(width:143,height:183).cornerRadius(10)
                            Text(anime.attributes.titles.en ?? anime.attributes.titles.en_jp ?? "").font(.custom(FontsManager.Montserrat.semiBold, size: 15))
                                .foregroundColor(Color("white"))
                                .padding(.leading, 7.0)
                                .frame(width: 135, alignment: .leading)
                                .lineLimit(1)
                        }
                    }
                    }
                }
            }
        }
        .onAppear(){
            vm.loadMoreContent()
        }
    }
}
