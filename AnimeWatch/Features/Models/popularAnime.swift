//
//  popularAnime.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

struct popularAnime: Decodable {
    let data: Anime
}

struct Anime: Decodable {
    let title: String;
    //let episodes: Int;
    let score: Double;
    let images: Images;
    let mal_id: Int?;
    let trailer: Trailer?;
}

struct Trailer: Decodable{
    let youtube_id: String?;
}

struct Images: Decodable{
    let jpg: Jpg
}

struct Jpg: Decodable{
    let image_url: String;
}
