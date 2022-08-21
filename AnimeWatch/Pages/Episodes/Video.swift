//
//  Video.swift
//  AnimeWatch
//
//  Created by Andrea on 23/04/22.
//

import SwiftUI
import PINCache
import GCDWebServer
import HLSCachingReverseProxyServer
import AVFoundation
import AVKit

struct VideoView: View {
    
    @State var player = AVPlayer()
    let playlistURL:  URL
    let server :  HLSCachingReverseProxyServer
    
    init(Url: String, Referer: String){
        self.playlistURL = URL(string: Url)!
        self.server = HLSCachingReverseProxyServer(webServer: GCDWebServer(), urlSession: URLSession.shared, cache: PINCache.shared, Referer: Referer)
    }
    
    var body: some View {
     VideoPlayer(player: player)
            .onAppear {
                
               if(playlistURL.pathExtension  == "mp4"){
                   return player = AVPlayer(url: playlistURL) //"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
                }
                
                server.start(port: 1234)
                        
                let reverseProxyURL = server.reverseProxyURL(from: playlistURL)!
                //file in formato .ts ritornati dal reverse proxy vanno a finire dentro l'av player
                let playerItem =  AVPlayerItem(url: reverseProxyURL)
                
                player.replaceCurrentItem(with: playerItem)
                // player.play()
            }
            .onDisappear {
                player.pause()
            }
    }
}
