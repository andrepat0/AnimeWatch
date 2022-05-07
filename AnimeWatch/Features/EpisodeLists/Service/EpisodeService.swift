//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol EpisodeService {
    func fetchData() async throws -> Episode
}

final class EpisodeServiceImpl: EpisodeService {
    
    let mal_id: Int?
    
    init(anime_id: Int?){
        self.mal_id = anime_id
    }
    
    func fetchData() async throws -> Episode {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.AniApi.baseUrl+"episode?anime_id=\(mal_id ?? 0)")!)
        let apiData =  try JSONDecoder().decode(Episode.self, from: data)
        return apiData
    }
}
