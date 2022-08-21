//
//  AnimeDetail.swift
//  AnimeWatch
//
//  Created by Andrea on 24/04/22.
//

import SwiftUI
import WebKit

struct AnimeDetailScreen: View {
    var data: AnimeDiscover;
    @State var AnimeRelated: [AnimeDetailsId] = []
    var bounds = UIScreen.main.bounds
    @StateObject private var JikanMalIdVM = GetAnimeByMalJikanViewModelImpl()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init(AnimeData: AnimeDiscover){
        self.data = AnimeData;
    }
    
    var body: some View {
        ScrollView{
            VStack{
                VStack(alignment: .leading){
                    Spacer()
                    HStack{
                        Text(data.titles.en ?? data.titles.rj ?? "")
                            .font(.custom(FontsManager.Montserrat.semiBold, size: 24))
                            .foregroundColor(Color("white"))
                            .padding()
                            .onAppear{
                               // print(data.recommendations)
                            }
                        Spacer()
                    }.frame(width: (bounds.size.width-20))
                        .background(.regularMaterial,in: RoundedRectangle(cornerRadius: 20, style: .circular))
                        .padding()
                }.frame(width: (bounds.size.width), height: (bounds.size.height / 2.7))
                    .background(AsyncImage(url: URL(string: data.banner_image ?? data.cover_image)!, placeholder: {
                        Color.black
                    }, image: {image in Image(uiImage: image).resizable()}))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                VStack{
                    TabView {
                        VStack{
                            HStack{
                                VStack(alignment: .center){
                                    Text("Episodes").padding(.bottom, 5.0)
                                        .font(.custom(FontsManager.Montserrat.regular, size: 16))
                                    Text("\(data.episodes_count)")
                                        .font(.custom(FontsManager.Luckiest_Guy.regular, size: 26))
                                }.frame(height:  60).padding().background(.regularMaterial,in: RoundedRectangle(cornerRadius: 15, style: .circular))
                                VStack(alignment: .center){
                                    Text("Score").padding(.bottom, 5.0)
                                        .font(.custom(FontsManager.Montserrat.regular, size: 18))
                                    Text("\(data.score)%")
                                        .font(.custom(FontsManager.Luckiest_Guy.regular, size: 32))
                                }.frame(width: 100, height:  60).padding().background(.regularMaterial,in: RoundedRectangle(cornerRadius: 15, style: .circular))
                                VStack(alignment: .center){
                                    Text("Duration").padding(.bottom, 5.0)
                                        .font(.custom(FontsManager.Montserrat.regular, size: 16))
                                    Text("\(data.episode_duration ?? 0) m")
                                        .font(.custom(FontsManager.Luckiest_Guy.regular, size: 24))
                                }.frame(height:  60).padding().background(.regularMaterial,in: RoundedRectangle(cornerRadius: 15, style: .circular))
                            }.frame(maxWidth: .infinity)
                            Spacer()
                            VStack{
                                Text("Description")
                                    .foregroundColor(Color("white"))
                                    .font(.custom(FontsManager.Montserrat.semiBold, size: 24))
                                ScrollView{
                                    Text("\(data.descriptions.en ?? "")")
                                        .font(.custom(FontsManager.Montserrat.regular, size: 15))
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                        
                        VStack{
                            Spacer()
                            Text("Trailer")
                                .foregroundColor(Color("white"))
                                .font(.custom(FontsManager.Montserrat.semiBold, size: 24))
                            YoutubeVideoView(videoId:(JikanMalIdVM.animeJikan.first)??.trailer?.youtube_id ?? "").cornerRadius(10).padding(.horizontal, 20)
                                .task{
                                    await JikanMalIdVM.getAnimeById(mal_id: data.mal_id ?? 0)
                                }
                        }
                        
                        ScrollView(.vertical, showsIndicators: true){
                            Spacer()
                            Text("Recommendations")
                                .foregroundColor(Color("white"))
                                .font(.custom(FontsManager.Montserrat.semiBold, size: 24))
                            if data.recommendations != nil {
                                ForEach(0..<(data.recommendations ?? []).count, id: \.self) { indx in
                                    ScrollView{
                                            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                                                ForEach(AnimeRelated, id: \.id){ animeRelated in
                                                    RelatedCardView(item: animeRelated ?? nil)
                                                }
                                        }
                                    }.task{
                                       // let vm = GetAnimeByIdViewModelImpl(service: GetAnimeByIdServiceImpl(anime_id: data.recommendations?[indx] ))
                                     //   await vm.getAnimeById()
                                    //     AnimeRelated = vm.animeRelated
                                        //print(AnimeRelated)
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: (bounds.size.width-20), height: (bounds.size.height - (bounds.size.height / 1.7)))
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
                
                Spacer()
                
                Button{
                    print("Test")
                } label: {
                    HStack{
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.white)
                        Text("Episodes").font(.custom(FontsManager.Montserrat.black, size: 18))
                            .foregroundColor(.white)
                    }.frame(width: 300, height: 30)
                        .padding()
                        .cornerRadius(10)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("lightOrange"),Color("darkOrange")]), startPoint: .top, endPoint: .bottom))
                        .clipShape(Capsule())
                }.padding(.leading, 10)

            }
        }.ignoresSafeArea()
    }
}
