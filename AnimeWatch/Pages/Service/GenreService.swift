//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol GenreService {
    func fetchData() async throws -> Genre
}

final class GenreServiceImpl: GenreService {
    
    func fetchData() async throws -> Genre {
       // let buildUrl = URL(string: (APIConstants.AniApi.baseUrl+"anime?title=\(Search_text ?? "")").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        let buildUrl = URL(string: ("https://kitsu.io/api/edge/categories?page%5Blimit%5D=10&page%5Boffset%5D=0&sort=-total_media_count"))
        
        guard let url = buildUrl else {
            throw NetworkError.badURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
            print(response)
            throw NetworkError.badID
        }
    
        let apiData =  try JSONDecoder().decode(Genre.self, from: data)
        return apiData
    }
}
