//
//  AnimeGenreList.swift
//  AnimeWatch
//
//  Created by Andrea on 11/06/22.
//

import SwiftUI

struct AnimeGenreList: View {
    let genre_id: String;
    let genre_title: String;
    @StateObject var dataSource = ContentDataSource()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        BackButton()
        
    }
    }
    
    var genreTitle : some View {
        Title(title: genre_title)
    }
    
    init(Genre_id: String, Genre_title: String){
        self.genre_id = Genre_id;
        self.genre_title = Genre_title;
    }
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItemLayout, spacing: 15) {
                ForEach(dataSource.items, id: \.id) { anime in
                    NavigationLink(destination: AnimeDetail(data: anime)) {
                        VStack(alignment:.leading){
                            ZStack{
                                AsyncImage(url: URL(string: anime.attributes.posterImage.small ?? "")!, placeholder: {
                                    Color.black
                                }, image: {image in Image(uiImage: image).resizable()})
                                
                            }.frame(height:160).cornerRadius(10).padding([.leading,.trailing])
                            Text(anime.attributes.titles.en ?? anime.attributes.titles.en_jp ?? "")
                                .font(.custom(FontsManager.Montserrat.regular, size: 13))
                                .frame(height: 25, alignment: .leading).lineLimit(2).padding([.leading,.trailing])
                                .foregroundColor(Color("white"))
                        }
                    }.onAppear(){
                        dataSource.loadMoreContentIfNeeded(currentItem: anime, Genre_id: genre_id)
                    }
                }
            }
            if dataSource.isLoadingPage {
                ProgressView()
            } else if(dataSource.items.count == 0){
                Text("No Data Found")
            }
        }
        .onAppear(){
            dataSource.loadMoreContent(genre_id: genre_id)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack, trailing: genreTitle)
    }
}
