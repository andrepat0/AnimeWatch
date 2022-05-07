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


class PlayerManager : ObservableObject {
    let player = AVPlayer()
    let server: HLSCachingReverseProxyServer
    let playlistURL: URL
    
    init(Referer: String, Url: String){
        self.server = HLSCachingReverseProxyServer(webServer: GCDWebServer(), urlSession: URLSession.shared, cache: PINCache.shared, referer: Referer)
        self.playlistURL = URL(string: Url)!
    }
    
    func startPlayer(){
        
        if(playlistURL.pathExtension  == "mp4"){
            player.replaceCurrentItem(with: AVPlayerItem(url: playlistURL))
            return player.play()
        }
        
        server.start(port: 1234)
                
        let reverseProxyURL = server.reverseProxyURL(from: playlistURL)!
        //file in formato .ts ritornati dal reverse proxy vanno a finire dentro l'av player
        let playerItem =  AVPlayerItem(url: reverseProxyURL)
        
        player.replaceCurrentItem(with: playerItem)
    }
    
    func playerStop(){
        player.pause()
    }
}

struct VideoView: View {
    
    let player = AVPlayer()
    let server: HLSCachingReverseProxyServer
    let playlistURL:  URL
    
    init(Url: String, Referer: String){
        self.server = HLSCachingReverseProxyServer(webServer: GCDWebServer(), urlSession: URLSession.shared, cache: PINCache.shared, referer: Referer)
        self.playlistURL = URL(string: Url)!
    }
    
    var body: some View {
     AVPlayerControllerRepresented(player: player)
            .onAppear {
                server.start(port: 1234)
                
                if(playlistURL.pathExtension  == "mp4"){
                    player.replaceCurrentItem(with: AVPlayerItem(url: playlistURL))
                    return player.play()
                }
                        
                let reverseProxyURL = server.reverseProxyURL(from: playlistURL)!
                //file in formato .ts ritornati dal reverse proxy vanno a finire dentro l'av player
                let playerItem =  AVPlayerItem(url: reverseProxyURL)
                
                player.replaceCurrentItem(with: playerItem)
                player.play()
            }
            .onDisappear {
                player.pause()
            }
    }
}
