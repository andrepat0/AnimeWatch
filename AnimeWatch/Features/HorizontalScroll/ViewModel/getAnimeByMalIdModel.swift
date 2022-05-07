//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

//ObservableObject permette al protocollo di restare in ascolto per cambiamenti
protocol GetAnimeByMalViewModel: ObservableObject {
    func getAnimeById() async
}

@MainActor
final class GetAnimeByMalViewModelImpl: GetAnimeByMalViewModel {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
   @Published private(set) var animeMal: [AnimeDetailsMalId]? = []
    //[AnimeDiscover] = []
    
    private let service: GetAnimeByMalService
    
    init(service: GetAnimeByMalService){
        self.service = service
    }
    
    func getAnimeById() async {
        do {
            animeMal.self =  try await (service.fetchData().data)?.documents
        } catch {
            print(error)
        }
    }
    
}
