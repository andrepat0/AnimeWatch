//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol RecommendationsService {
    func fetchData() async throws -> popularAnime
}

final class RecommendationsServiceImpl: RecommendationsService {
    
    func fetchData() async throws -> popularAnime {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.Kitsu.baseUrl+"anime?sort=-userCount")!)
        let apiData =  try JSONDecoder().decode(popularAnime.self, from: data)
        return apiData
    }
}
