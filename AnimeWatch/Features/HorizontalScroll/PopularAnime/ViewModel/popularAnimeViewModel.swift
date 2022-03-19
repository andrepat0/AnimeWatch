//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

//ObservableObject permette al protocollo di restare in ascolto per cambiamenti
protocol PopularAnimeViewModel: ObservableObject {
    func getPopularAnime() async
}

@MainActor
final class PopularAnimeViewModelImpl: PopularAnimeViewModel {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
    @Published private(set) var popularAnimes: [Anime] = []
    
    private let service: PopularAnimeService
    
    init(service: PopularAnimeService){
        self.service = service
    }
    
    func getPopularAnime() async {
        do {
            popularAnimes.self =  try await service.fetchPopularAnime().data
        } catch {
            print(error)
        }
    }
    
}
