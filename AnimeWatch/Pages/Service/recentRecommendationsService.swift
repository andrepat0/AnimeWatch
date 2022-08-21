//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol recentRecommendationsService {
    func fetchData() async throws -> recentRecommendations
}

final class recentRecommendationsServiceImpl: recentRecommendationsService {
    
    func fetchData() async throws -> recentRecommendations {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.Kitsu.baseUrl+"recommendations/anime")!)
        let apiData =  try JSONDecoder().decode(recentRecommendations.self, from: data)
        return apiData
    }
}
