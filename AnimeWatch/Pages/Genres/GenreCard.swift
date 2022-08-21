//
//  Card.swift
//  AnimeWatch
//
//  Created by Andrea on 14/03/22.
//

import Foundation

import SwiftUI

struct GenreCardView: View {
    var data: GenreDetail;
    @Environment(\.presentationMode) var presentationMode
    
    init(item: GenreDetail){
        self.data = item;
    }
    
    var body: some View {
        NavigationLink(destination: AnimeGenreList(Genre_id: data.id, Genre_title: data.attributes.title)){
            VStack{
                Text(data.attributes.title).font(.custom(FontsManager.Montserrat.black, size: 18)).foregroundColor(Color(.white))
            }.frame(width: 150, height: 85)
            .background(LinearGradient(gradient: Gradient(colors: [Color("lightOrange"),Color("darkOrange")]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(10)
        }
    }
}

//data.images.jpg.image_url
