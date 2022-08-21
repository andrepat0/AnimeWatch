//
//  HorizontalTabView.swift
//  AnimeWatch
//
//  Created by Andrea on 14/05/22.
//

import SwiftUI

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct HorizontalTabView: View {
    
    /* Variabili di stato */
    @State var showAnimeDetail: Bool = false
    @State private var selection: String = "Trama"
    @State private var tabSelection: TabBarItem = TabBarItem(title: "Trama")
    
    var data: Attributes
    var animeGenres: [GenreAnimeDetail]
    var animeCharacters: [CharactersDetail]
    var animeReactions: [ReactionsAnimeDetail]
    var userReactions: [ReactionsIncluded]
    var averageRating: Double
    var bounds = UIScreen.main.bounds
    
    init(data: Attributes, anime_genres: [GenreAnimeDetail], anime_characters: [CharactersDetail], anime_reactions: [ReactionsAnimeDetail], reactions_user: [ReactionsIncluded]){
        self.data = data
        self.averageRating = Double(self.data.attributes.averageRating ?? "0") ?? 0.0
        self.animeGenres = anime_genres
        self.animeCharacters = anime_characters
        self.animeReactions = anime_reactions
        self.userReactions = reactions_user
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                VStack{
                    
                    VStack(alignment: .leading){
                    }.frame(width: (bounds.size.width), height: 380)
                        .background(AsyncImage(url: URL(string: (data.attributes.posterImage.medium) ?? "")!, placeholder: {
                            Color.black
                        }, image: {image in Image(uiImage: image).resizable()}))
                    
                    /*  Tab Trama */
                    CustomTabBarContainerView(selection: $tabSelection){
                        if showAnimeDetail {
                            Trama(data: self.data,animeGenres: self.animeGenres, animeCharacters: self.animeCharacters, animeReactions: self.animeReactions, averageRating: self.averageRating)
                                .transition(.move(edge: .bottom))
                                .tabBarItem(tab: TabBarItem(title: "Trama"), selection: $tabSelection)
                        }
                        Color.red
                            .tabBarItem(tab: TabBarItem(title: "Episodes"), selection: $tabSelection)
                        Color.green
                            .tabBarItem(tab: TabBarItem(title: "Related"), selection: $tabSelection)
                    }
                }
            }
        }
        .onAppear(){
            withAnimation(.easeInOut(duration: 0.5)) {
                self.showAnimeDetail = true
            }
        }
        .ignoresSafeArea()
        
    }
}
