//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation
import Combine

class EpisodesDataSource: ObservableObject {
  @Published var episodes = [EpisodesAttributes]()
  @Published var isLoadingPage = false
  private var currentPage = 0
  private var canLoadMorePages = true

    func loadMoreContentIfNeeded(currentItem item: EpisodesAttributes?, Anime_Id: String) {
    guard let item = item else {
      loadMoreContent(anime_id: Anime_Id)
      return
    }

    let thresholdIndex = episodes.index(episodes.endIndex, offsetBy: -5)
    if episodes.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
      loadMoreContent(anime_id: Anime_Id)
    }
  }

    func loadMoreContent(anime_id: String) {
    guard !isLoadingPage && canLoadMorePages else {
      return
    }
    isLoadingPage = true
    let url = URL(string: APIConstants.Kitsu.baseUrl+"episodes?filter[mediaType]=Anime&filter[media_id]=\(anime_id)&page[limit]=15&page[offset]=\(currentPage)&sort=number")!
    URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: EpisodesList.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .handleEvents(receiveOutput: { response in
          self.canLoadMorePages = response.links.next != nil
                 self.isLoadingPage = false
                 self.currentPage += 15
               })
               .map({ response in
                 return self.episodes + response.data
               })
               .catch({ _ in Just(self.episodes) })
                        .assign(to: &$episodes)
           }
        }



//Model
struct EpisodesList: Decodable {
    let data: [EpisodesAttributes]
    let links: LinksAnime
}

struct EpisodesAttributes: Decodable {
    let attributes: EpisodeData?;
    let id: String?;
}

struct EpisodeData: Decodable {
    let canonicalTitle: String?;
    let number: Int?;
    let thumbnail: ThumbnailEpisode?;
}

struct ThumbnailEpisode: Decodable {
    let original: String?;
}
