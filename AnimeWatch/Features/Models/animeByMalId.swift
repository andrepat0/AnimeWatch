//
//  popularAnime.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

struct animeByMalId: Decodable {
    let data: Doc?;
}

struct Doc: Decodable {
    let documents: [AnimeDetailsMalId];
}

struct AnimeDetailsMalId: Decodable {
    let titles: TitlesValue;
    let episodes_count: Int;
    let score: Int;
    let cover_image: String;
    let id: Int;
}

struct TitlesValue: Decodable{
    let en: String?
    let rj: String?;
}
