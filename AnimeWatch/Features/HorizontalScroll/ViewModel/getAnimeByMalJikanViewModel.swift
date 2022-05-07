//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

//ObservableObject permette al protocollo di restare in ascolto per cambiamenti
protocol GetAnimeByMalJikanViewModel: ObservableObject {
    func getAnimeById() async
}

@MainActor
final class GetAnimeByMalJikanViewModelImpl: GetAnimeByMalJikanViewModel {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
   @Published private(set) var animeJikan: [Anime] = []
    //[AnimeDiscover] = []
    
    private let service: GetAnimeByMalJikanService
    
    init(service: GetAnimeByMalJikanService){
        self.service = service
    }
    
    func getAnimeById() async {
        do {
            animeJikan.self = [try await service.fetchData().data]
        } catch {
            print(error)
        }
    }
    
}
