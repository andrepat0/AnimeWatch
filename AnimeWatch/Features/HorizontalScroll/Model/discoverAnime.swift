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
    let episodes_count: Int;
    let score: Int;
    let cover_image: String;
    let id: Int;
}

struct Titles: Decodable{
    let en: String?
    let rj: String?;
}
