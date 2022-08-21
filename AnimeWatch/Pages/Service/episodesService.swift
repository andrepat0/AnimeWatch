//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

final class episodesService {
    func fetchData() async throws -> popularAnime {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.Kitsu.baseUrl+"trending/anime")!)
        let apiData =  try JSONDecoder().decode(popularAnime.self, from: data)
        return apiData
    }
}
