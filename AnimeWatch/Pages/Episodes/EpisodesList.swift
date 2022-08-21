//
//  PopularAnimeScreen.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import SwiftUI
import AVFoundation
import PINCache
import GCDWebServer
import HLSCachingReverseProxyServer

struct EpisodeListScreen: View {
    
    @StateObject var vmEpisodes =  EpisodeViewModelImpl()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

       var btnBack : some View { Button(action: {
           self.presentationMode.wrappedValue.dismiss()
           }) {
               HStack{
                   LinearGradient(gradient: Gradient(colors: [Color("lightOrange"),Color("darkOrange")]), startPoint: .top, endPoint: .bottom).mask(
                       Image(systemName: "arrow.left")
                           .aspectRatio(contentMode: .fit)
                   ).frame(width: 25, height:40)
                       .padding(.leading, 10)
                   Text(title.count > 40 ? title.prefix(40)+"..." : title)
                       .font(.custom(FontsManager.Montserrat.regular, size: 12))
                       .padding(.trailing, 10)
               }.background(.regularMaterial,in: RoundedRectangle(cornerRadius: 20, style: .circular))
                   .ignoresSafeArea()
               Spacer()
           }
       }
    var player = AVPlayer()
    var anime_id: Int;
    var title: String;
    var anime_image: String
    
    init(id: Int, anime_title: String,image: String){
        anime_id = id;
        title = anime_title;
        anime_image = image;
    }
    
    //Stateobject permette alla variabile di restare in ascolto per eventuali cambiamenti che avvengono nella variabile Published del protocollo ObservableObject
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical, showsIndicators: false){
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                  /*  if((vmEpisodes.episodeList).count == 0){
                        Text("No Episodes Found")
                            .font(.custom(FontsManager.Montserrat.regular, size: 18))
                            .padding()
                        }else{ */
                            ForEach(vmEpisodes.episodeList,id: \.video){ episode in
                                NavigationLink(destination: VideoView(Url: episode.video, Referer: episode.video_headers.referer ?? "")){
                                VStack(alignment: .leading){
                                    ZStack{
                                        AsyncImage(url: URL(string: anime_image ?? "")!, placeholder: {
                                            Color.black
                                        }, image: {image in Image(uiImage: image).resizable()}).opacity(0.8)
                                        Image(systemName: "play.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(Color.white)
                                    }.frame(width:150,height:150)
                                        .cornerRadius(10)
                                    Text(episode.title)
                                        .font(.custom(FontsManager.Montserrat.regular, size: 18))
                                        .frame(width: 150,height: 40, alignment: .top).lineLimit(2)
                                        .foregroundColor(Color("white"))
                                }
                         }
                      /*  } */
                      }
                    }
                }
            }.navigationBarTitle(title+" Episodes")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
            .task{
                await vmEpisodes.getEpisodeList(anime_id: anime_id)
                print(vmEpisodes.episodeList)
            }
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
