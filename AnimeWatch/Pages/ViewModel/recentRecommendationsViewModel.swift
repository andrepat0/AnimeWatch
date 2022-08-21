//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

@MainActor
final class recentRecommendationsViewModel: ObservableObject {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
    @Published private(set) var animeReccomendations: [AnimeRecentRecommendations] = []
    
    func getAnimeRecommendations() async {
        do {
            animeReccomendations.self = try await recentRecommendationsServiceImpl().fetchData().data
        } catch {
            print(error)
        }
    }
}

struct recentRecommendations: Decodable {
    let data: [AnimeRecentRecommendations]
}

struct AnimeRecentRecommendations: Decodable {
    let entry: [AnimeRecentRecInfo]
    let content: String
    let date: String
}

struct AnimeRecentRecInfo: Decodable {
    let mal_id:Int
    let images: Images
    let title:String
    
}
