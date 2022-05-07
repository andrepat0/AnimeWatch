//
//  PopularAnimeScreen.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import SwiftUI
import AVFoundation

struct EpisodeListScreen: View {
    
    @ObservedObject var vm: EpisodeViewModelImpl
    var player = AVPlayer()
    
    init( Vm: EpisodeViewModelImpl){
        self.vm = Vm
    }
    
    //Stateobject permette alla variabile di restare in ascolto per eventuali cambiamenti che avvengono nella variabile Published del protocollo ObservableObject
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Episode list")
                .padding(.leading,10)
                .font(.custom(FontsManager.Montserrat.semiBold, size: 24))
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack{
                    if((vm.episodeList).count == 0){
                        Text("No Episode Found")
                        }else{
                            ForEach(vm.episodeList,id: \.title){ episode in
                                NavigationLink(destination: VideoView(Url: episode.video, Referer: episode.video_headers.referer ?? "")){
                                    
                                    Text(episode.title)
                                        .font(.custom(FontsManager.Luckiest_Guy.regular, size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue
                                                        .cornerRadius(10)
                                                        .shadow(radius: 10))
                            
                           }
                        }
                      }
                    }
                }
            }
            .task{
                await vm.getEpisodeList()
            }
        }
}

struct EpisodeListScreen_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListScreen(Vm: EpisodeViewModelImpl(service: EpisodeServiceImpl(anime_id: 2)))
    }
}

/*
 - @State for very simple data like Int, Bool, or String. Think situations like whether a toggle is on or off, or whether a dialog is open or closed.
 - @StateObject to create any type that is more complex than what @State can handle. Ensure that the type conforms to ObservableObject, and has @Published wrappers on the properties you would like to cause the view to re-render, or you’d like to update from a view.
 Always use @StateObject when you are instantiating a model.
 - @ObservedObject to allow a parent view to pass down to a child view an already created ObservableObject (via @StateObject).
 - @EnvironmentObject to consume an ObservableObject that has already been created in a parent view and then attached via the view’s environmentObject() view modifier.
 - @Binding to share one value between 2 Views
 
 */
