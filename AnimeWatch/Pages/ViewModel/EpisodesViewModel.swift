//
//  EpisodesViewModel.swift
//  AnimeWatch
//
//  Created by Andrea on 21/08/22.
//

import Foundation



//Model
struct Episodes: Decodable {
    let data: [EpisodesAttributes]
}

struct EpisodesAttributes: Decodable {
    let attributes: Anime;
    let id: String;
    let relationships: Characters;
}
