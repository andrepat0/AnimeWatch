//
//  Card.swift
//  AnimeWatch
//
//  Created by Andrea on 14/03/22.
//

import Foundation

import SwiftUI

struct RelatedCardView: View {
    var data: AnimeDetailsId?;
    
    init(item: AnimeDetailsId?){
        self.data = item;
    }
    
    var body: some View {
        if data != nil {
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
                    HStack{
                        Spacer()
                        
                        VStack(alignment: .center,spacing: 5){
                            Image("Vector")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 20)
                            Text("\(data?.score ?? 0)").font(.custom(FontsManager.Montserrat.black, size: 14)).foregroundColor(Color("white"))
                            
                        }.frame(width: 51, height: 46)
                            .background(.regularMaterial,in: RoundedRectangle(cornerRadius: 10, style: .circular))
                        
                        
                    }
                    Spacer()
                }.frame(width:143,height:210)
                    .padding(8)
                    .background(AsyncImage(url: URL(string: data?.cover_image ?? "")!, placeholder: {
                        Color.black
                    }, image: {image in Image(uiImage: image).resizable()}))
                    .cornerRadius(10)
                
                Text(data?.titles.en ?? data?.titles.rj ?? "").font(.custom(FontsManager.Montserrat.semiBold, size: 15)).foregroundColor(Color("white")).padding(.leading, 7.0).frame(width: 143,height: 40, alignment: .top).lineLimit(2)
            }
        } else{
            Text("No Related Anime")
        }
    }
}
