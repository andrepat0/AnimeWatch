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
    @Published private(set) var animeLists: [Attributes] = []
    
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


//Model
struct popularAnime: Decodable {
    let data: [Attributes]
}

struct Attributes: Decodable {
    let attributes: Anime;
    let id: String;
    let type: String;
    let relationships: Characters;
}

struct Characters: Decodable{
let characters: Links;
}

struct Links: Decodable{
    let links: Related;
}

struct Related: Decodable{
    let related: String;
}



struct Anime: Decodable{
    let titles: Titles;
    let synopsis: String?;
    let averageRating: String?;
    let posterImage: PosterImages;
    let episodeCount: Int?;
    let youtubeVideoId: String?;
    let startDate: String?;
    let subtype: String?;
    
}

struct Titles: Decodable{
    let en: String?;
    let en_jp: String?;
}

struct PosterImages: Decodable {
    let small: String?
    let medium: String?
}

