//
//  ReverseProxyServer.swift
//  AnimeWatch
//
//  Created by Andrea on 03/04/22.
//

import AVKit
import HLSCachingReverseProxyServer
import PINCache
import GCDWebServer

struct ReverseProxyServer {
    
    var server: HLSCachingReverseProxyServer
    
    //Inizializza il reverse proxy server
    let WebServer = GCDWebServer()
    let Cache = PINCache.shared
    let UrlSession = URLSession.shared
    let Referer: String
    
    init(referer: String){
        self.Referer = referer
        self.server = HLSCachingReverseProxyServer(webServer: WebServer, urlSession: UrlSession, cache: Cache, referer: Referer)
    }
    
    func startServer() -> HLSCachingReverseProxyServer{
        server.start(port: 1234)
        return server
    }
    
}
