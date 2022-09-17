//
//  PopularAnimeScreen.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import SwiftUI
import Popovers

struct AnimeRecommendationsScreen: View {
    //Stateobject permette alla variabile di restare in ascolto per eventuali cambiamenti che avvengono nella variabile Published del protocollo ObservableObject
    @StateObject private var vm = RecommendationsViewModel()
    @State var present = 0
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Reccomendations")
                .foregroundColor(Color("white"))
                .font(.custom(FontsManager.Montserrat.bold, size: 22))
                .fontWeight(.medium)
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(alignment: .leading){
                    ForEach(vm.animeReccomendations,id: \.id){ anime in
                       NavigationLink(destination: AnimeDetail(data: anime)) {
                            HStack{
                                RoundedRectangle(cornerRadius: 15).overlay(
                                    AsyncImage(url: URL(string: anime.attributes.posterImage.small ?? anime.attributes.posterImage.small ?? "" )!, placeholder: {
                                        Color.black
                                    }, image: {image in Image(uiImage: image).resizable()})
                                ).frame(width: 110, height: 100).cornerRadius(15).padding(.bottom,5)
                                VStack(alignment: .leading){
                                    Text(anime.attributes.titles.en ?? anime.attributes.titles.en_jp ?? "").font(.custom(FontsManager.Montserrat.semiBold, size: 15))
                                    Text(((anime.attributes.synopsis ?? "")+"...")).font(.custom(FontsManager.Montserrat.regular, size: 10)).foregroundColor(Color("white")).lineLimit(5) .multilineTextAlignment(.leading)
                                    Spacer()
                                }.frame(height: 110)
                            }.padding(.trailing, 10)
                     }
               }
            }
            .task{
                await vm.getAnimeRecommendations()
            }
        }.frame( height: 365)
    }
    }
}
