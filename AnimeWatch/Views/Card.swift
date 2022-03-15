//
//  Card.swift
//  AnimeWatch
//
//  Created by Andrea on 14/03/22.
//

import Foundation

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                
                VStack(alignment: .center,spacing: 5){
                
                    Image("Vector")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 20)
                    Text("78.8%").font(.custom(FontsManager.Luckiest_Guy.regular, size: 15)).foregroundColor(.white)
                    
                }.frame(width: 51, height: 46)
                    .background(Color("darkGray"))
                    .cornerRadius(10)
            
            
            }
            Spacer()
        }.frame(width:143,height:210)
        .padding(8)
        .cornerRadius(20)
        .background(Image("animeBackground").resizable().aspectRatio(contentMode: .fit))
    }
}

struct CardView_Preview : PreviewProvider{
    static var previews: some View{
        Group{
            CardView().previewLayout(.sizeThatFits)
        }
    }
}
