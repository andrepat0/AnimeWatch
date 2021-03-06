import SwiftUI
import AVKit

struct BufferVideoPlayerView: View {
    
    let
    
    @StateObject private var videoPlayerVM = VideoPlayerViewModel(video: Video(name: "Promo Video", streams: [
        Stream(resolution: .p360, streamURL: URL(string: "YOUR-VIDEO-360p.m3u8")!),
        Stream(resolution: .p540, streamURL: URL(string: "YOUR-VIDEO-540p.m3u8")!),
        Stream(resolution: .p720, streamURL: URL(string: "YOUR-VIDEO-720p.m3u8")!),
        Stream(resolution: .p1080, streamURL: URL(string: "YOUR-VIDEO-1080p.m3u8")!)
    ]), initialResolution: .p540)
 
    @State private var showResolutions = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button("Change resolution") {
                    withAnimation {
                        showResolutions.toggle()
                    }
                }
                .font(Font.body.bold())
                VideoPlayer(player: videoPlayerVM.player) {
                    Text(videoPlayerVM.namePlusResolution)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(8)
                }
                .frame(height: 220)
                .onAppear() {
                    
                    videoPlayerVM.player.play()
                }
            }
            .padding()
            if showResolutions {
                VStack(spacing: 20) {
                    Spacer()
                    ForEach(Resolution.allCases) { resolution in
                        Button(resolution.displayValue, action: {
                            withAnimation {
                                videoPlayerVM.selectedResolution = resolution
                                showResolutions.toggle()
                            }
                        })
                    }
                    Button(action: {
                        withAnimation {
                            showResolutions.toggle()
                        }
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .imageScale(.large)
                    })
                        .padding(.top)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .transition(.move(edge: .bottom))
            }
        }
        .navigationBarTitle("Observing player's status")
    }
}
