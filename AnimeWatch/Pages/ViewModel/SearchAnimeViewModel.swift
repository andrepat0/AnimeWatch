//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

@MainActor
final class SearchAnimeViewModelImpl: ObservableObject {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
   @Published private(set) var animeSearched: [Attributes?] = []
    
    func getAnimeById(text: String) async {
        do {
            animeSearched.self = try await SearchAnimeServiceImpl(search_text: text).fetchData().data
        } catch {
            print(error)
        }
    }
    
}

//Model
struct searchAnime: Decodable {
    let data: [Attributes?];
}


struct SearchedAnime: Decodable {
    let title: String?;
    let images: Images;
    let synopsis: String?;
    let mal_id: Int;
    let score: Double?;
}

struct Images: Decodable {
    let jpg: Jpg;
}

struct Jpg: Decodable {
    let image_url: String?;
}

struct DescriptionAnimeSearched: Decodable {
    let en: String;
}

struct TitlesAnimeSearched: Decodable{
    let en: String?
    let rj: String?;
}

