//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol aniApiService {
    func fetchData() async throws -> discoverAnime
}

final class aniApiServiceImpl: aniApiService {
    
    func fetchData() async throws -> discoverAnime {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.AniApi.baseUrl+"random/anime/10/false")!)
        let apiData =  try JSONDecoder().decode(discoverAnime.self, from: data)
        return apiData
    }
}
