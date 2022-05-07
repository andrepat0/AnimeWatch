//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol GetAnimeByMalJikanService {
    func fetchData() async throws -> popularAnime
}

final class GetAnimeByMalJikanServiceImpl: GetAnimeByMalJikanService {
    
    let mal_id: Int?
    
    init(anime_id: Int?){
        self.mal_id = anime_id
    }
    
    func fetchData() async throws -> popularAnime {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.Jikan.baseUrl+"anime/\(mal_id ?? 0)")!)
        let apiData =  try JSONDecoder().decode(popularAnime.self, from: data)
        return apiData
    }
}
