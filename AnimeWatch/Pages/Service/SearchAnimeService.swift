//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

protocol SearchAnimeService {
    func fetchData() async throws -> searchAnime
}

enum NetworkError: Error {
    case badURL
    case badID
}

final class SearchAnimeServiceImpl: SearchAnimeService {
    
    let Search_text: String?
    
    init(search_text: String){
        self.Search_text = search_text
    }
    
    func fetchData() async throws -> searchAnime {
       // let buildUrl = URL(string: (APIConstants.AniApi.baseUrl+"anime?title=\(Search_text ?? "")").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        let buildUrl = URL(string: (APIConstants.Kitsu.baseUrl+"anime?filter[text]=\(Search_text ?? "")").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        guard let url = buildUrl else {
            throw NetworkError.badURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
            print(response)
            throw NetworkError.badID
        }
    
        let apiData =  try JSONDecoder().decode(searchAnime.self, from: data)
        return apiData
    }
}
