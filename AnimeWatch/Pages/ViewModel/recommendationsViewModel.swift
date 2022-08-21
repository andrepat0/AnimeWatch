//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

@MainActor
final class RecommendationsViewModel: ObservableObject {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
    @Published private(set) var animeReccomendations: [Attributes] = []
    
    func getAnimeRecommendations() async {
        do {
            animeReccomendations.self = try await RecommendationsServiceImpl().fetchData().data
        } catch {
            print(error)
        }
    }
    
}


