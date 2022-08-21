//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

@MainActor
final class GenreViewModelImpl: ObservableObject {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
   @Published private(set) var genres: [GenreDetail] = []
    
    func getGenre() async {
        do {
            genres.self = try await GenreServiceImpl().fetchData().data
        } catch {
            print(error)
        }
    }
    
}

//Model
struct Genre: Decodable {
    let data: [GenreDetail];
    let links: LinksAnime;
}

struct GenreDetail: Decodable {
    let id: String;
    let attributes: GenreAttribute;
}

struct GenreAttribute: Decodable {
    let title: String;
}
