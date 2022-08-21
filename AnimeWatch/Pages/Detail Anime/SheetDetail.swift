//
//  SheetDetail.swift
//  AnimeWatch
//
//  Created by Andrea on 14/08/22.
//

import SwiftUI

struct SheetDetail: View {
    var body: some View {
        VStack(alignment: .leading){
            VStack{
                
                /* Titolo + Rating */
                HStack{
                    VStack(alignment: .leading){
                        Text(data.attributes.titles.en ?? data.attributes.titles.en_jp ?? "")
                            .font(.custom(FontsManager.Montserrat.bold, size: 24))
                            .foregroundColor(Color("white"))
                        Text((data.attributes.startDate)?.prefix(4) ?? "").font(.custom(FontsManager.Montserrat.thin, size: 18))
                            .foregroundColor(Color("white"))
                    }.padding(.leading)
                    Spacer()
                    VStack{
                        StarAssignment(score: Double(String(format:"%.0f",averageRating)) ?? 0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 30)
                            .padding(.top)
                        Text(String(format:"%.1f",averageRating)+"%").font(.custom(FontsManager.Montserrat.regular, size: 18)).foregroundColor(Color("white"))
                            .padding([.leading,.trailing,.bottom])
                    }.background(.regularMaterial,in: RoundedRectangle(cornerRadius: 30, style: .circular))
                }
                
                /* Generi Anime */
                ScrollView(.horizontal){
                    HStack{
                        ForEach(animeGenres,id: \.attributes.name){ animeGenre in
                            Capsule()
                                .frame(width: 110, height: 50)
                                .padding([.bottom,.top])
                                .foregroundColor(Color("lightGray"))
                                .overlay(
                                    Text(animeGenre.attributes.name).foregroundColor(.white)
                                        .padding(5)
                                        .truncationMode(.tail)
                                )
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
                if(animeCharacters.count > 0){
                    VStack(alignment: .leading){
                        Text("Characters")
                            .font(.custom(FontsManager.Montserrat.regular, size: 22))
                            .foregroundColor(Color("white"))
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(animeCharacters,id: \.id){ animeCharacter in
                                    Capsule()
                                        .frame(width: 100, height: 50)
                                        .overlay(
                                            Text(animeCharacter.id).foregroundColor(.white)
                                                .padding(3)
                                        )
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
                
                /* Reazioni */
                if(animeReactions.count > 0){
                    VStack(alignment: .leading){
                        Text("Reactions")
                            .font(.custom(FontsManager.Montserrat.regular, size: 22))
                            .foregroundColor(Color("white"))
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(animeReactions,id: \.id){ animeReaction in
                                    Rectangle()
                                        .frame(width: 300, height: 150)
                                        .cornerRadius(10)
                                        .foregroundColor(Color("lightGray"))
                                        .overlay(
                                            HStack{
                                                Text(animeReaction.attributes.reaction ?? "")
                                                    .font(.custom(FontsManager.Montserrat.regular, size: 14))
                                                    .foregroundColor(.white)
                                                Spacer()
                                                VStack{
                                                    HStack{
                                                        Image(systemName: "hand.thumbsup")
                                                        Text("\(animeReaction.attributes.upVotesCount ?? 0)")
                                                            .font(.custom(FontsManager.Montserrat.regular, size: 16))
                                                    }.padding()
                                                        .background(.regularMaterial,in: RoundedRectangle(cornerRadius: 40, style: .circular))
                                                    Spacer()
                                                }
                                                
                                            }.padding()
                                        )
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
            }
        }
    }
}
