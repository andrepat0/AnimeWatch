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
    var anime: Attributes;
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

       var btnBack : some View { Button(action: {
           self.presentationMode.wrappedValue.dismiss()
           }) {
               HStack {
               Image("ic_back") // set image here
                   .aspectRatio(contentMode: .fit)
                   .foregroundColor(.white)
                   Text("Go back")
               }
           }
       }
    var averageRating = 0.0
    
    init(item: Attributes){
        self.anime = item;
        self.averageRating = Double(item.attributes.averageRating ?? "0") ?? 0.0
    }
    
    var body: some View {
        NavigationLink(destination: AnimeDetail(data: anime)) {
            VStack(alignment: .leading){
                    VStack(alignment: .leading) {
                            HStack{
                                
                                Spacer()
                                
                                VStack(alignment: .center,spacing: 5){
                                    StarAssignment(score: averageRating)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 20)
                                    Text("\(String(format:"%.1f",averageRating))%").font(.custom(FontsManager.Montserrat.bold, size: 14)).foregroundColor(Color("white"))
                                    
                                }.frame(width: 51, height: 46)
                                    .background(.regularMaterial,in: RoundedRectangle(cornerRadius: 10, style: .circular))

                                
                                
                            }
                            Spacer()
                        }.frame(width:143,height:183)
                            .padding(8)
                            .background(AsyncImage(url: URL(string: anime.attributes.posterImage.small ?? "")!, placeholder: {
                                Color.black
                            }, image: {image in Image(uiImage: image).resizable()}))
                            .cornerRadius(10)
                Text(anime.attributes.titles.en ?? anime.attributes.titles.en_jp ?? "").font(.custom(FontsManager.Montserrat.semiBold, size: 15))
                    .foregroundColor(Color("white"))
                    .padding(.leading, 7.0)
                    .frame(width: 135, alignment: .leading)
                    .lineLimit(1)
                }
        }
  }
}
