//
//  popularAnime.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

struct animeById: Decodable {
    let data: AnimeDetailsId;
}

struct AnimeDetailsId: Decodable {
    let titles: TitlesValueAnimeId;
    let episodes_count: Int;
    let score: Int;
    let cover_image: String;
    let id: Int;
}

struct TitlesValueAnimeId: Decodable{
    let en: String?
    let rj: String?;
}
