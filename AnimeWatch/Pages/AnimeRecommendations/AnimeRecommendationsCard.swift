//
//  Card.swift
//  AnimeWatch
//
//  Created by Andrea on 14/03/22.
//

import Foundation

import SwiftUI
import Network

struct PopularCardView: View {
    var data: AnimeRecommendations;
    @State var animeId: Int? = 0;
    
    init(item: Anime){
        self.data = item;
    }
    
    var body: some View {
        NavigationLink(destination: AnimeDetailJikanScreen(anime_id: data.mal_id ?? 0, data: data)) {
            VStack(alignment: .leading){
                    VStack(alignment: .leading) {
                            HStack{
                                
                                Spacer()
                                
                                VStack(alignment: .center,spacing: 5){
                                   StarAssignment(score: Int(data.score*10))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 20)
                                    Text("\(String(format:"%.1f",data.score*10))%").font(.custom(FontsManager.Montserrat.bold, size: 14)).foregroundColor(Color("white"))
                                    
                                }.frame(width: 51, height: 46)
                                    .background(.regularMaterial,in: RoundedRectangle(cornerRadius: 10, style: .circular))

                                
                                
                            }
                            Spacer()
                        }.frame(width:143,height:210)
                            .padding(8)
                            .background(AsyncImage(url: URL(string: data.images.jpg.image_url ?? "")!, placeholder: {
                                Color.black
                            }, image: {image in Image(uiImage: image).resizable()}))
                            .cornerRadius(10)
                Text(data.title).font(.custom(FontsManager.Montserrat.semiBold, size: 15)).foregroundColor(Color("white")).padding(.leading, 7.0).frame(width: 143,height: 40, alignment: .top).lineLimit(2)
                    .task{
                        let vm = GetAnimeByMalViewModelImpl(service: GetAnimeByMalServiceImpl(anime_id: data.mal_id ?? 0))
                        await vm.getAnimeById()
                        animeId = (vm.animeMal!).count == 0 ? 0 : (vm.animeMal!)[0].id
                    }
                }
       }
  }
}
