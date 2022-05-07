import Foundation
import GCDWebServer
import PINCache
import HLSCachingReverseProxyServer
import AVKit

class HlsReverseProxy: ObservableObject {
    
    @Published var player = AVPlayer()
    private let originURLKey = "__hls_origin_url"
    // Inizilizzazione web server
    func initWebServer() {

        let webServer = GCDWebServer()
        let cache = PINCache.shared
        let urlSession = URLSession.shared
        let server = HLSCachingReverseProxyServer(webServer: webServer, urlSession: urlSession, cache: cache)
        server.start(port: 1234)
        
        playVideo(server: server)
    }
    
    func playVideo(server: HLSCachingReverseProxyServer){
        let playlistURL = URL(string: "https://cph-msl.akamaized.net/hls/live/2000341/test/master.m3u8")!
        let reverseProxyURL = server.reverseProxyURL(from: playlistURL)!
        let playerItem = AVPlayerItem(url: reverseProxyURL)
        self.player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
}

