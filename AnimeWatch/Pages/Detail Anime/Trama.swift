//
//  Trama.swift
//  AnimeWatch
//
//  Created by Andrea on 21/08/22.
//

import SwiftUI

struct Trama: View {
    
    var data: Attributes
    var selection: TabBarItem
    var averageRating: Double
    @StateObject private var vmAnimeAdditionalData = AdditionalAnimeDataViewModelImpl()
    
    @State var showAnimeDetail: Bool = false
    
    init(data: Attributes, averageRating: Double, Selection: TabBarItem){
        self.data = data
        self.averageRating = averageRating
        self.selection = Selection
    }
    
    var body: some View {
        VStack(alignment: .leading){
            if selection.title == "Trama" {
                VStack{
                    
                    /* Titolo + Rating */
                    HStack{
                        VStack(alignment: .leading){
                            Text(data.attributes.titles.en ?? data.attributes.titles.en_jp ?? "")
                                .font(.custom(FontsManager.Montserrat.bold, size: 24))
                                .foregroundColor(Color("white"))
                            Text((data.attributes.startDate)?.prefix(4) ?? "").font(.custom(FontsManager.Montserrat.thin, size: 18))
                                .foregroundColor(Color("white"))
                            Spacer()
                        }.padding(.leading)
                        Spacer()
                        VStack{
                            StarAssignment(score: Double(String(format:"%.0f",averageRating)) ?? 0)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .padding(.top,10)
                            Text(String(format:"%.1f",averageRating)+"%").font(.custom(FontsManager.Montserrat.semiBold, size: 18)).foregroundColor(Color("white"))
                                .padding([.leading,.trailing,.bottom])
                                .padding(.top,-5)
                        }
                        .background(.regularMaterial,in: RoundedRectangle(cornerRadius: 30, style: .circular))
                        .offset(x: 5, y: -5)
                    }
                    Spacer()
                    
                    /* Generi Anime */
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(vmAnimeAdditionalData.genreList,id: \.attributes.name){ animeGenre in
                                ZStack{
                                    Text(animeGenre.attributes.name).foregroundColor(Color("white"))
                                        .padding(5)
                                        .truncationMode(.tail)
                                }.frame(width: 110, height: 25)
                                    .padding([.bottom,.top])
                                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 30, style: .circular))
                            }
                        }
                    }
                    
                    /* Descrizione */
                    ScrollView(showsIndicators: true){
                        Text("\(data.attributes.synopsis ?? "")")
                            .font(.custom(FontsManager.Montserrat.regular, size: 15))
                            .foregroundColor(Color("white"))
                            .truncationMode(.tail)
                    }.frame(height: 165)
                    
                    /* Youtube Video */
                    if((data.attributes.youtubeVideoId) != nil){
                        VStack(alignment: .leading){
                            Text("Trailer")
                                .font(.custom(FontsManager.Montserrat.regular, size: 22))
                                .foregroundColor(Color("white"))
                            YoutubeVideoView(videoId: data.attributes.youtubeVideoId ?? "")
                                .cornerRadius(10)
                                .frame(height: 200)
                        }
                        .padding(.top)
                    }
                    
                    /* Personaggi */
                    if(vmAnimeAdditionalData.charactersList.count > 0){
                        VStack(alignment: .leading){
                            Text("Characters")
                                .font(.custom(FontsManager.Montserrat.regular, size: 22))
                                .foregroundColor(Color("white"))
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(vmAnimeAdditionalData.charactersList,id: \.id){ animeCharacter in
                                        VStack(alignment: .leading){
                                            ZStack{
                                                AsyncImage(url: URL(string: animeCharacter.attributes.image.original ?? "")!, placeholder: {
                                                    Color.black
                                                }, image: {image in Image(uiImage: image).resizable()})
                                                
                                            }.frame(width: 120, height: 120).cornerRadius(10)
                                            
                                            Text(animeCharacter.attributes.canonicalName ?? "")
                                                .font(.custom(FontsManager.Montserrat.regular, size: 15))
                                                .lineLimit(1)
                                                .frame(width: 120)
                                                .multilineTextAlignment(.leading)
                                            
                                            
                                        }.padding(.trailing,10)
                                    }
                                }
                            }
                        }
                        .padding(.top)
                    }
                    
                    /* Reazioni */
                    if(vmAnimeAdditionalData.reactionsList.count > 0){
                        VStack(alignment: .leading){
                            Text("Reactions")
                                .font(.custom(FontsManager.Montserrat.regular, size: 22))
                                .foregroundColor(Color("white"))
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(vmAnimeAdditionalData.reactionsList,id: \.id){ animeReaction in
                                        ZStack{
                                            HStack{
                                                
                                                VStack(alignment: .leading){
                                                    
                                                    Text(animeReaction.attributes.reaction ?? "")
                                                        .font(.custom(FontsManager.Montserrat.regular, size: 14))
                                                        .foregroundColor(Color("white"))
                                                    Spacer()
                                                    Text((animeReaction.attributes.updatedAt ?? "").prefix(10))
                                                        .font(.custom(FontsManager.Montserrat.italic, size: 12))
                                                        .foregroundColor(Color("white"))
                                                }
                                                
                                                
                                                Spacer()
                                                VStack{
                                                    VStack(){
                                                        ZStack {
                                                            LinearGradient(gradient: Gradient(colors: [Color("lightOrange"),Color("darkOrange")]), startPoint: .top, endPoint: .bottom).mask(
                                                                Image(systemName: "hand.thumbsup")
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit))
                                                            
                                                        }.frame(width: 25, height: 25)
                                                        Text("\(animeReaction.attributes.upVotesCount ?? 0)")
                                                            .font(.custom(FontsManager.Montserrat.regular, size: 16))
                                                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("lightOrange"),Color("darkOrange")]), startPoint: .top, endPoint: .bottom))
                                                    }.padding()
                                                        .background(.white)
                                                        .cornerRadius(30)
                                                    Spacer()
                                                    Spacer()
                                                }
                                                
                                            }.padding()
                                        }  .frame(width: 300, height: 130)
                                            .background(.regularMaterial,in: RoundedRectangle(cornerRadius: 20, style: .circular))
                                        
                                        // )
                                    }
                                }
                            }
                        }
                        .padding(.top)
                    }
                }.padding()
                    .padding(.bottom,30)
                    .background(Color(.white))
                    .foregroundColor(Color.black)
                    .cornerRadius(40)
          //  }
        }
            }
        .task{
            await vmAnimeAdditionalData.getAnimeList(anime_id: data.id ?? "0")
        }
    }
}
