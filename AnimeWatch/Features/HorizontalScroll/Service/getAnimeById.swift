//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol GetAnimeByIdService {
    func fetchData() async throws -> animeById
}

final class GetAnimeByIdServiceImpl: GetAnimeByIdService {
    
    let id: Int?
    
    init(anime_id: Int?){
        self.id = anime_id
    }
    
    func fetchData() async throws -> animeById {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.AniApi.baseUrl+"anime/\(id ?? 0)")!)
        let apiData =  try JSONDecoder().decode(animeById.self, from: data)
        return apiData
    }
}
