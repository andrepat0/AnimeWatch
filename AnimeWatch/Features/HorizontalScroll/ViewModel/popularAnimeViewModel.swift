//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

//ObservableObject permette al protocollo di restare in ascolto per cambiamenti
protocol AnimeListViewModel: ObservableObject {
    func getAnimeList() async
}

@MainActor
final class AnimeListViewModelImpl: AnimeListViewModel {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
    @Published private(set) var animeLists: [Anime] = []
    
    private let service: jikanService
    
    init(service: jikanService){
        self.service = service
    }
    
    func getAnimeList() async {
        do {
            animeLists.self =  try await service.fetchData().data
        } catch {
            print(error)
        }
    }
    
}
