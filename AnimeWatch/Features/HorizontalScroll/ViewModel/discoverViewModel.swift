//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

//ObservableObject permette al protocollo di restare in ascolto per cambiamenti
protocol DiscoverViewModel: ObservableObject {
    func getAnimeList() async
}

@MainActor
final class DiscoverViewModelImpl: AnimeListViewModel {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
    @Published private(set) var discoverAnimeLists: [AnimeDiscover] = []
    //[AnimeDiscover] = []
    
    private let service: aniApiService
    
    init(service: aniApiService){
        self.service = service
    }
    
    func getAnimeList() async {
        do {
            discoverAnimeLists.self =  try await service.fetchData().data
            print(discoverAnimeLists)
        } catch {
            print(error)
        }
    }
    
}
