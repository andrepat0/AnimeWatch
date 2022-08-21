//
//  AnimeDetail.swift
//  AnimeWatch
//
//  Created by Andrea on 24/04/22.
//

import SwiftUI
import WebKit


struct AnimeDetail: View {
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
       var btnBack : some View { Button(action: {
           self.presentationMode.wrappedValue.dismiss()
           }) {
               HStack{
                       ZStack{
                           Image(systemName: "xmark")
                               .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 20, height: 20)
                                     .font(.headline)
                                     //.foregroundColor(.white)
                                     .padding()
                       }.background(.regularMaterial,in: RoundedRectangle(cornerRadius: 40, style: .circular))
               }
           }
       }
    
    var data: Attributes?
    @StateObject private var vmAnimeAdditionalData = AdditionalAnimeDataViewModelImpl()
    
    init(data: Attributes?){
        self.data = data
    }
    
    var body: some View {
        HorizontalTabView(data: data!, anime_genres: vmAnimeAdditionalData.genreList, anime_characters: vmAnimeAdditionalData.charactersList, anime_reactions: vmAnimeAdditionalData.reactionsList, reactions_user: vmAnimeAdditionalData.userReactions)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: btnBack)
            .task(){
              await vmAnimeAdditionalData.getAnimeList(anime_id: data?.id ?? "0")
            }
    }
}


