//
//  SearchCard.swift
//  AnimeWatch
//
//  Created by Andrea on 08/05/22.
//

import SwiftUI
import WebKit


struct SearchCard: View {
    let data: Attributes
    let score: Double
    
    init(Data: Attributes){
        data = Data
        score = Double(Data.attributes.averageRating ?? "0") ?? 0.0
    }
    
    var body: some View {
        NavigationLink(destination: AnimeDetail(data: data)){
            HStack{
                RoundedRectangle(cornerRadius: 15).overlay(
                    AsyncImage(url: URL(string: data.attributes.posterImage.small ?? "" )!, placeholder: {
                        Color.black
                    }, image: {image in Image(uiImage: image).resizable()})
                ).frame(width: 130, height:130).cornerRadius(15)
                VStack(alignment: .leading){
                    Text(data.attributes.titles.en ?? data.attributes.titles.en_jp ?? "").font(.custom(FontsManager.Montserrat.semiBold, size: 15))
                    HStack(){
                        StarAssignment(score: Double(String(format:"%.0f",score)) ?? 0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 20)
                        Text(String(format:"%.1f",score)).font(.custom(FontsManager.Montserrat.bold, size: 14)).foregroundColor(Color("white"))
                    }
                    Text(((data.attributes.synopsis ?? "")+"...").prefix(150)).font(.custom(FontsManager.Montserrat.regular, size: 10)).foregroundColor(Color("white"))
                }
                
            }.frame(height: 150).padding(.trailing, 10)
        }
    }
}
