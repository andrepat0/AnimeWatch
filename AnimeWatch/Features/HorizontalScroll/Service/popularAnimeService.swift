//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol jikanService {
    func fetchData() async throws -> popularAnime
}

final class jikanServiceImpl: jikanService {
    
    func fetchData() async throws -> popularAnime {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.Jikan.baseUrl+"top/anime")!)
        let apiData =  try JSONDecoder().decode(popularAnime.self, from: data)
        return apiData
    }
}
