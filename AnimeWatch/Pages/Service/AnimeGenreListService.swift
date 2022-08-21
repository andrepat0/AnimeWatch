//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation
import Combine

class ContentDataSource: ObservableObject {
  @Published var items = [Attributes]()
  @Published var isLoadingPage = false
  private var currentPage = 0
  private var canLoadMorePages = true

    func loadMoreContentIfNeeded(currentItem item: Attributes?, Genre_id: String) {
    guard let item = item else {
      loadMoreContent(genre_id: Genre_id)
      return
    }

    let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
    if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
      loadMoreContent(genre_id: Genre_id)
    }
  }

    func loadMoreContent(genre_id: String) {
    guard !isLoadingPage && canLoadMorePages else {
      return
    }
    isLoadingPage = true
    let url = URL(string: "https://kitsu.io/api/edge/categories/"+genre_id+"/anime?page%5Blimit%5D=10&page%5Boffset%5D=\(currentPage)")!
        print(url)
    URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: AnimeGenre.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .handleEvents(receiveOutput: { response in
          self.canLoadMorePages = response.links.next != nil
                 self.isLoadingPage = false
                 self.currentPage += 10
               })
               .map({ response in
                 return self.items + response.data
               })
               .catch({ _ in Just(self.items) })
                        .assign(to: &$items)
           }
        }



struct AnimeGenre: Decodable {
    let data: [Attributes];
    let meta: MetaAnime;
    let links: LinksAnime;
}

struct MetaAnime: Decodable {
    let count: Int?
}

struct LinksAnime: Decodable {
    let next: String?;
}

 struct AnimeGenreDetail: Decodable {
    let id: String;
    let attributes: AnimeGenreAttributes;
}

struct AnimeGenreAttributes: Decodable {
    let titles: TitlesAnime;
    let synopsis: String?;
    let userCount: Int?;
    let episodeCount: Int?;
    let averageRating: String?;
    let posterImage: PosterImage;
    let youtubeVideoId: String?;
    let status: String?;
    let ageRatingGuide: String?;
    //let coverImage: CoverImage;
}

struct TitlesAnime: Decodable {
    let en: String?
    let en_jp: String?;
}

struct PosterImage: Decodable {
    let small: String?;
}

