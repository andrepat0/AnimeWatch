//
//  SearchScreen.swift
//  AnimeWatch
//
//  Created by Andrea on 07/05/22.
//

import SwiftUI

struct SearchScreen: View {
    @State private var searchText = ""
    @StateObject private var SearchVM = SearchAnimeViewModelImpl()
    

    var searchTitle : some View {
        Title(title: "Search")
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(SearchVM.animeSearched, id: \.?.attributes.titles.en){ anime in
                    if((anime) != nil){
                        SearchCard(Data: anime!)
                    }
                }
            }
            .searchable(text: $searchText, prompt:"Search Anime, Manga, Movies")
            .onChange(of: searchText, perform: { searchText in
                async{
                    if !searchText.isEmpty && searchText.count > 1 {
                        await SearchVM.getAnimeById(text: searchText)
                    }else{
                        
                    }
                }
            })
            .navigationTitle("Search")
           .navigationBarBackButtonHidden(true)
            }
            //.navigationBarTitle("")
           // .navigationBarBackButtonHidden(true)
           // .navigationBarItems(leading: searchTitle)
        }
}

    
struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
