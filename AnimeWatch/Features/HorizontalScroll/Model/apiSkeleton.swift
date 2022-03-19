//
//  apiSkeleton.swift
//  AnimeWatch
//
//  Created by Andrea on 15/03/22.
//

import Foundation

import SwiftUI

struct Anime: Hashable, Codable{
    let title: String;
}

class APIModel: ObservableObject{
    @Published var animes: [Anime] = []
    
    func fetch(urlString: String){
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _ ) in
            //Convert to JSON
            do{
                let animes = try JSONDecoder().decode([Anime].self,from: data!)
                DispatchQueue.main.async {
                    self.animes = animes
                }
            }catch{
                print(error)
            }
        }
        .resume()
    }
}
