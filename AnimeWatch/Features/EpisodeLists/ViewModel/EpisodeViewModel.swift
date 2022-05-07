//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation
import SwiftUI

//ObservableObject permette al protocollo di restare in ascolto per cambiamenti
protocol EpisodeViewModel: ObservableObject {
    func getEpisodeList() async
}

@MainActor
final class EpisodeViewModelImpl: EpisodeViewModel {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
    @Published private(set) var episodeList: [EpisodeDetail] = []
    
    private let service: EpisodeService
    
    init(service: EpisodeService){
        self.service = service
    }
    
    func getEpisodeList() async {
        do {
            episodeList.self =  try await service.fetchData().data.documents
        } catch {
            print(error)
        }
    }
    
}
