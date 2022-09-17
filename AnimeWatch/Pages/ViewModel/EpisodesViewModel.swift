//
//  EpisodesViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 21/08/22.
//

import Foundation


@MainActor
final class EpisodesViewModel: ObservableObject {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
    @Published private(set) var episodeLists: [EpisodesAttributes] = []
    
    
    func getEpisodeList(anime_id: String) async {
        do {
            episodeLists.self =  try await EpisodesService(Anime_Id: anime_id).fetchData().data
        } catch {
            print(error)
        }
    }
    
}

