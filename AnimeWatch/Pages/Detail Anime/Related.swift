//
//  Episodes.swift
//  AnimeWatch
//
//  Created by Andrea on 21/08/22.
//

import SwiftUI

struct Relateds: View {
    
    var data: Attributes
    var selection : TabBarItem
    @StateObject private var vm = AnimeRelatedDataSource()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(data: Attributes, Selection: TabBarItem){
        self.data = data
        self.selection = Selection
    }
    
    func CapitalizeWord(word: String) -> String {
        // 1
        let firstLetter = word.prefix(1).capitalized
        // 2
        let remainingLetters = word.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            if selection.title == "Related" {
                VStack{
                    HStack{
                        Text(data.attributes.titles.en ?? data.attributes.titles.en_jp ?? "")
                            .font(.custom(FontsManager.Montserrat.bold, size: 24))
                            .foregroundColor(Color("white"))
                        Spacer()
                        Text("Related").font(.custom(FontsManager.Montserrat.regular, size: 18))
                            .foregroundColor(Color("white"))
                        Spacer()
                    }.padding(.leading)
                    Spacer()
                    ScrollView{
                        LazyVGrid(columns: gridItemLayout, spacing: 15) {
                            ForEach(vm.animeRelated, id: \.id) { anime in
                                NavigationLink(destination: AnimeDetail(data: anime)) {
                                    VStack(alignment:.leading){
                                        ZStack{
                                            if((anime.attributes.posterImage.small) != nil){
                                                AsyncImage(url: URL(string: anime.attributes.posterImage.small ?? "")!, placeholder: {
                                                    Color.black
                                                }, image: {image in Image(uiImage: image).resizable()})
                                            }else{
                                                RoundedRectangle(cornerRadius: 10)
                                            }
                                            
                                        }.frame(height:140).cornerRadius(10) .padding([.leading,.trailing],10)
                                        VStack(alignment:.leading){
                                            Text(anime.attributes.titles.en ?? anime.attributes.titles.en_jp ?? "")
                                                .font(.custom(FontsManager.Montserrat.semiBold, size: 15))
                                                .padding([.leading,.trailing],10)
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(Color("white"))
                                            HStack{
                                                Text("\(CapitalizeWord(word: anime.type ?? "")) ")
                                                    .font(.custom(FontsManager.Montserrat.semiBold, size: 13))
                                                    .padding([.leading],10)
                                                    .foregroundColor(Color("white"))
                                                
                                                Text("-")
                                                    .font(.custom(FontsManager.Montserrat.regular, size: 13))
                                                    .foregroundColor(Color("white"))
                                                
                                                Text(CapitalizeWord(word: anime.attributes.subtype ?? ""))
                                                    .font(.custom(FontsManager.Montserrat.regular, size: 13))
                                                    .padding([.trailing],10)
                                                    .foregroundColor(Color("white"))
                                                Spacer()
                            
                                            }
                                        }.frame(height: 35)
                                    }
                                }
                                .onAppear(){
                                    vm.loadMoreContentIfNeeded(currentItem: anime, Anime_Id: data.id)
                                }
                            }
                        }
                        if vm.isLoadingPage {
                            ProgressView()
                        } else if(vm.animeRelated.count == 0){
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
