//
//  popularAnimeViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

@MainActor
final class AdditionalAnimeDataViewModelImpl: ObservableObject {
    //La variabile Published dice ad ogni view che la contiene e che la sta ascoltando (tramite StateObject) che il valore al suo interno è cambiato e quindi dovrebbe ricostruire le View
    @Published private(set) var genreList: [GenreAnimeDetail] = []
    @Published private(set) var charactersList: [CharactersDetail] = []
    @Published private(set) var reactionsList: [ReactionsAnimeDetail] = []
    @Published private(set) var userReactions: [ReactionsIncluded] = []
    
    func getAnimeList(anime_id: String) async {
        do {
            let reactions = try await additionalAnimeServiceImpl(animeId: anime_id).fetchDataReactions()
            genreList.self =  try await additionalAnimeServiceImpl(animeId: anime_id).fetchDataGenres().data
            charactersList.self = try await additionalAnimeServiceImpl(animeId: anime_id).fetchDataCharacters().included
            reactionsList.self = reactions.data
            userReactions.self = reactions.included
        } catch {
            print(error)
        }
    }
    
}

//Model Genre Anime
struct GenreAnime: Decodable {
    let data: [GenreAnimeDetail];
    let links: LinksAnime;
}

struct GenreAnimeDetail: Decodable {
    let attributes: GenreAnimeAttribute;
}

struct GenreAnimeAttribute: Decodable {
    let name: String;
}

//Model Characters Anime
struct CharactersAnime: Decodable {
    let included: [CharactersDetail]
}

struct CharactersDetail: Decodable{
    let attributes: CharactersAttributes;
    let id: String
}

struct CharactersAttributes: Decodable{
    let canonicalName:  String?
    let image: CharactersImages;
}

struct CharactersImages: Decodable{
    let original: String?;
}

//Model Reactions Anime
struct ReactionsAnime: Decodable {
    let data: [ReactionsAnimeDetail]
    let included: [ReactionsIncluded]
}

struct ReactionsIncluded: Decodable{
    let attributes: UserAttributes
    let id: String
}

struct UserAttributes: Decodable{
    let name: String?
   let avatar: Avatar?
}

struct Avatar: Decodable{
    let small: String?;
}

struct ReactionsAnimeDetail: Decodable{
    let attributes: ReactionsAttribute
    let id: String
}

struct ReactionsAttribute: Decodable{
    let reaction: String?
    let updatedAt: String?
    let upVotesCount: Int?
}

