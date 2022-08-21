//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation
import Combine

class GetAllGenresDataSource: ObservableObject {
  @Published var items = [GenreDetail]()
  @Published var isLoadingPage = false
  private var currentPage = 0
  private var canLoadMorePages = true

    func loadMoreContentIfNeeded(currentItem item: GenreDetail?) {
    guard let item = item else {
      loadMoreContent()
      return
    }

    let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
    if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
      loadMoreContent()
    }
  }

    func loadMoreContent() {
        
    guard !isLoadingPage && canLoadMorePages else {
      return
    }
        
    isLoadingPage = true
    let url = URL(string: "https://kitsu.io/api/edge/categories?page%5Blimit%5D=30&page%5Boffset%5D=\(currentPage)&sort=-total_media_count")!
    URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: Genre.self, decoder: JSONDecoder())
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

