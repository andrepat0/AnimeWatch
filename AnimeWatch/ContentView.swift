//
//  ContentView.swift
//  AnimeWatch
//
//  Created by Andrea on 14/03/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var apiModel = APIModel()
    var body: some View {
        
       ScrollView(.horizontal, showsIndicators: false){
        LazyHStack{
                ForEach(apiModel.animes,id: \.self){ anime in
                    Text(anime.title)
                    // CardView().shadow(color: Color.black.opacity(0.2),radius:5,x: 5,y: 5)
                }
            }
        }.padding(20)
        .onAppear {
                apiModel.fetch(urlString: "https://jsonplaceholder.typicode.com/posts")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
