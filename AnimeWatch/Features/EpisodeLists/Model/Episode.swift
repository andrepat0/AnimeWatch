//
//  popularAnime.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation

struct Episode: Decodable {
    let data: Documents
}

struct Documents: Decodable {
    let documents: [EpisodeDetail]
}

struct EpisodeDetail: Decodable {
    let title: String;
    let video: String;
    let number: Int;
    let video_headers: VideoHeaders;
    let id: Int;
}

struct VideoHeaders: Decodable{
    let referer: String?
}
