//
//  VideoPlayerVM.swift
//  StreamingApp
//
//  Created by Moritz Philip Recke on 26.10.21 for createwithswift.com.
//

import Foundation
import Combine
import AVKit

final class VideoPlayerViewModel: ObservableObject {
    @Published var selectedResolution: Resolution
    @Published private var shouldLowerResolution = false

    let player = AVPlayer()
    private let video: Video
    private var subscriptions: Set<AnyCancellable> = []
    private var timeObserverToken: Any?
    
    var name: String { video.name }
    var namePlusResolution: String { video.name + " at " + selectedResolution.displayValue }

    init(video: Video, initialResolution: Resolution) {
        self.video = video
        self.selectedResolution = initialResolution
        
        $shouldLowerResolution
            .dropFirst()
            .filter({ $0 == true })
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.lowerResolutionIfPossible()
            })
            .store(in: &subscriptions)
        
        $selectedResolution
            .sink(receiveValue: { [weak self] resolution in
                guard let self = self else { return }
                self.replaceItem(with: resolution)
                self.setObserver()
            })
            .store(in: &subscriptions)
    }
    
    deinit {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
        }
    }
    
    private func setObserver() {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
        }
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 600), queue: DispatchQueue.main, using: { [weak self] time in
            guard let self = self,
                  let currentItem = self.player.currentItem else { return }
            
            guard currentItem.isPlaybackBufferFull == false else {
                self.shouldLowerResolution = false
                return
            }
            
            if currentItem.status == AVPlayerItem.Status.readyToPlay {
                self.shouldLowerResolution = (!currentItem.isPlaybackLikelyToKeepUp && !currentItem.isPlaybackBufferEmpty)
            }
        })
    }
    
    private func lowerResolutionIfPossible() {
        guard let newResolution = Resolution(rawValue: selectedResolution.rawValue - 1) else { return }
        selectedResolution = newResolution
    }
    
    private func replaceItem(with newResolution: Resolution) {
        guard let stream = self.video.streams.first(where: { $0.resolution == newResolution }) else { return }
        let currentTime: CMTime
        if let currentItem = player.currentItem {
            currentTime = currentItem.currentTime()
        } else {
            currentTime = .zero
        }
        
        player.replaceCurrentItem(with: AVPlayerItem(url: stream.streamURL))
        player.seek(to: currentTime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
}

extension VideoPlayerViewModel {
    static var `default`: Self {
        .init(video: Video(name: "Promo Video", streams: [
            Stream(resolution: .p360, streamURL: URL(string: "https://ekerp.vizcloud.xyz/simple/EqPFIPsQBAro1HhYl67rC8YurVxfu7a6EA17rqk+wYMnU94US2El/br/H1/v.m3u8")!),
            Stream(resolution: .p480, streamURL: URL(string: "https://ekerp.vizcloud.xyz/simple/EqPFIPsQBAro1HhYl67rC8YurVxfu7a6EA17rqk+wYMnU94US2El/br/H2/v.m3u8")!),
        ]), initialResolution: .p480)
    }
}
