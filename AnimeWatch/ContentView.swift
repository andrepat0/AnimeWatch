//
//  ContentView.swift
//  AnimeWatch
//
//  Created by Andrea on 14/03/22.
//

import SwiftUI
import AVFoundation
import AVKit
import HLSCachingReverseProxyServer
import PINCache
import GCDWebServer
import AVKit

struct ContentView: View {
    
    init(){
        //UITabBar.appearance().barTintColor = .systemBackground
    }
    
    var body: some View {
            TabView{
                HomeScreen()
                    .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                
                Text("Search").tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Search")
                }
            }.accentColor(Color("darkOrange"))
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/* .onAppear {
 
 //Passo la url da cercare
 let playlistURL = URL(string: "https://ekerp.vizcloud2.online/simple/EqPFI_oQBAro1HhYl67rC8Auq1wcvrmzAEB7rqk+wYMnU94US2El/br/list.m3u8")!
 
 if(playlistURL.pathExtension  == "mp4"){
 player.replaceCurrentItem(with: AVPlayerItem(url: playlistURL))
 return player.play()
 }
 server.start(port: 1234)
 
 //https://ekerp.vizcloud2.online/simple/EqPFI_oQBAro1HhYl67rC8Auq1wcvrmzAEB7rqk+wYMnU94US2El/br/list.m3u8
 //creo la url che dovrà passare al reverse proxy costruita come: "server locale" + "__hls_origin_url" + "server origine", poi gli handler del reverseproxy fanno la richiesta al server d'origine che mi ritorna i file in formato .ts
 let reverseProxyURL = server.reverseProxyURL(from: playlistURL)!
 //file in formato .ts ritornati dal reverse proxy vanno a finire dentro l'av player
 let playerItem =  AVPlayerItem(url: reverseProxyURL)
 
 player.replaceCurrentItem(with: playerItem)
 player.play()
 }
 .onDisappear {
 player.pause()
 server.stop()
 }*/
