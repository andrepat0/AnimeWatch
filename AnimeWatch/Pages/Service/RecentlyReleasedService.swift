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

class RecentlyReleasedDataSource: ObservableObject {
  @Published var recentlyReleasedAnimeList = [Attributes]()

    func loadMoreContent() {
    let url = URL(string: APIConstants.Kitsu.baseUrl+"anime?filter[status]=current&page[limit]=10&sort=-user_count")!
    URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: RecentlyReleasedAnimeList.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
               .map({ response in
                 return self.recentlyReleasedAnimeList + response.data
               })
               .catch({ _ in Just(self.recentlyReleasedAnimeList) })
                        .assign(to: &$recentlyReleasedAnimeList)
           }
}



//Model
struct RecentlyReleasedAnimeList: Decodable {
    let data: [Attributes]
    let links: LinksAnime
}


