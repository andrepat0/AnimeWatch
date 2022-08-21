//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

final class additionalAnimeServiceImpl {
    
    
    let id: String
    
    init(animeId: String){
        id.self = animeId
    }
    
    func fetchDataGenres() async throws -> GenreAnime {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.Kitsu.baseUrl+"/anime/"+id+"/genres")!)
        let apiData =  try JSONDecoder().decode(GenreAnime.self, from: data)
        return apiData
    }
    
    func fetchDataCharacters() async throws -> CharactersAnime {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.Kitsu.baseUrl+"/anime/"+id+"/anime-characters?include=character")!)
        let apiData =  try JSONDecoder().decode(CharactersAnime.self, from: data)
        return apiData
    }
    
    func fetchDataReactions() async throws -> ReactionsAnime {
        let urlSession = URLSession.shared
        let (data, _) = try await urlSession.data(from: URL(string: APIConstants.Kitsu.baseUrl+"media-reactions?filter[animeId]="+id+"&include=user&sort=-upVotesCount")!)
        let apiData =  try JSONDecoder().decode(ReactionsAnime.self, from: data)
        return apiData
    }
}
