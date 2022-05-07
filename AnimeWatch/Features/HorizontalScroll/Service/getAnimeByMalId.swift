//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol GetAnimeByMalService {
    func fetchData() async throws -> animeByMalId
}

final class GetAnimeByMalServiceImpl: GetAnimeByMalService {
    
    let mal_id: Int?
    
    init(anime_id: Int?){
        self.mal_id = anime_id
    }
    
    func fetchData() async throws -> animeByMalId {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.AniApi.baseUrl+"anime?mal_id=\(mal_id ?? 0)")!)
        let apiData =  try JSONDecoder().decode(animeByMalId.self, from: data)
        return apiData
    }
}
