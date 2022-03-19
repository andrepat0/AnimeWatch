//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol PopularAnimeService {
    func fetchPopularAnime() async throws -> PopularAnime
}

final class PopularAnimeServiceImpl: PopularAnimeService {
    func fetchPopularAnime() async throws -> PopularAnime {
        let urlSession = URLSession.shared
        let url = URL(string: APIConstants.baseUrl+"top/anime")
        let (data, _) = try await urlSession.data(from: url!)
        let apiData =  try JSONDecoder().decode(PopularAnime.self, from: data)
        return apiData
    }
}
