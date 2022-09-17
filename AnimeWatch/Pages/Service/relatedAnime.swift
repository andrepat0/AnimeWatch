//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation
import Combine

class AnimeRelatedDataSource: ObservableObject {
  @Published var animeRelated = [Attributes]()
  @Published var isLoadingPage = false
  private var currentPage = 0
  private var canLoadMorePages = true

    func loadMoreContentIfNeeded(currentItem item: Attributes?, Anime_Id: String) {
    guard let item = item else {
      loadMoreContent(anime_id: Anime_Id)
      return
    }

    let thresholdIndex = animeRelated.index(animeRelated.endIndex, offsetBy: -5)
    if animeRelated.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
      loadMoreContent(anime_id: Anime_Id)
    }
  }

    func loadMoreContent(anime_id: String) {
    guard !isLoadingPage && canLoadMorePages else {
      return
    }
    isLoadingPage = true
    let url = URL(string: APIConstants.Kitsu.baseUrl+"media-relationships?filter[source_id]=\(anime_id)&filter[source_type]=Anime&include=destination&sort=role&page[limit]=15&page[offset]=\(currentPage)")!
    URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: AnimeRelatedList.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .handleEvents(receiveOutput: { response in
          self.canLoadMorePages = response.links.next != nil
                 self.isLoadingPage = false
                 self.currentPage += 15
               })
               .map({ response in
                 return self.animeRelated + response.included
               })
               .catch({ _ in Just(self.animeRelated) })
                        .assign(to: &$animeRelated)
           }
        }



//Model
struct AnimeRelatedList: Decodable {
    let links: LinksAnime
    let included: [Attributes];
}
