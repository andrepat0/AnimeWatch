//
//  Episodes.swift
//  AnimeWatch
//
//  Created by Andrea on 21/08/22.
//

import SwiftUI

struct Episodes: View {
    
    var data: Attributes
    var selection : TabBarItem
    @StateObject private var vm = EpisodesDataSource()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(data: Attributes, Selection: TabBarItem){
        self.data = data
        self.selection = Selection
    }
    
    var body: some View {
            VStack(alignment: .leading){
                if selection.title == "Episodes" {
                VStack{
                    HStack{
                        Text(data.attributes.titles.en ?? data.attributes.titles.en_jp ?? "")
                            .font(.custom(FontsManager.Montserrat.bold, size: 24))
                            .foregroundColor(Color("white"))
                        Spacer()
                        Text("Episodes").font(.custom(FontsManager.Montserrat.regular, size: 18))
                            .foregroundColor(Color("white"))
                        Spacer()
                    }.padding(.leading)
                    Spacer()
                    ScrollView{
                        LazyVGrid(columns: gridItemLayout, spacing: 15) {
                            ForEach(vm.episodes, id: \.id) { episode in
                                VStack(alignment:.leading){
                                    ZStack{
                                        if((episode.attributes?.thumbnail?.original) != nil){
                                            AsyncImage(url: URL(string: episode.attributes?.thumbnail?.original ?? "")!, placeholder: {
                                                Color.black
                                            }, image: {image in Image(uiImage: image).resizable()})
                                        }else{
                                            RoundedRectangle(cornerRadius: 10)
                                        }
                                        
                                    }.frame(height:140).cornerRadius(10) .padding([.leading,.trailing],10)
                                    VStack(alignment:.leading){
                                        Text("Episode \(episode.attributes?.number ?? 0)")
                                            .font(.custom(FontsManager.Montserrat.semiBold, size: 15))
                                           .padding([.leading,.trailing],10)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color("white"))
                                        Text(episode.attributes?.canonicalTitle ?? "")
                                            .font(.custom(FontsManager.Montserrat.regular, size: 13))
                                            .padding([.leading,.trailing],10)
                                            .lineLimit(2)
                                            .foregroundColor(Color("white"))
                                    }.frame(height: 35)
                                }
                                .onAppear(){
                                    vm.loadMoreContentIfNeeded(currentItem: episode, Anime_Id: data.id)
                                }
                            }
                        }
                        if vm.isLoadingPage {
                            ProgressView()
                        } else if(vm.episodes.count == 0){
                            Text("No Data Found")
                        }
                    }.padding(.top)
                }
                .padding()
                .padding(.bottom,30)
                .background(Color(.white))
                .foregroundColor(Color.black)
                .cornerRadius(40)
            }
        }
            .onAppear(){
                vm.loadMoreContent(anime_id: data.id)
            }
    }
}
