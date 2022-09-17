//
//  upcomingAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/09/22.
//
//
//  popularAnimeService.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import Foundation
import Combine

class UpcomingAnimeDataSource: ObservableObject {
  @Published var upcomingAnime = [Attributes]()

    func loadMoreContent() {
    let url = URL(string: APIConstants.Kitsu.baseUrl+"anime?filter[status]=upcoming&page[limit]=10&sort=-user_count")!
    URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: UpcomingAnimeList.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
               .map({ response in
                 return self.upcomingAnime + response.data
               })
               .catch({ _ in Just(self.upcomingAnime) })
                        .assign(to: &$upcomingAnime)
           }
}



//Model
struct UpcomingAnimeList: Decodable {
    let data: [Attributes]
    let links: LinksAnime
}


