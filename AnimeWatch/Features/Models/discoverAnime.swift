//
//  popularAnime.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

struct discoverAnime: Decodable {
    let data: [AnimeDiscover]
}

struct AnimeDiscover: Decodable {
    let titles: Titles;
    let mal_id: Int?;
    let episodes_count: Int;
    let score: Int;
    let cover_image: String;
    let id: Int;
    let banner_image: String?;
    let descriptions: Description
    let genres: [String]
    let episode_duration: Int?
    let status: Int
    let recommendations: [Int]?
    // let mal_id: Int;
}

struct Description: Decodable{
    let en: String?;
    let it: String?;
    let jp: String?;
}

struct Titles: Decodable{
    let en: String?
    let rj: String?;
}
