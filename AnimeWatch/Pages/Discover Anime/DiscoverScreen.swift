//
//  PopularAnimeScreen.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import SwiftUI

struct DiscoverScreen: View {
    //Stateobject permette alla variabile di restare in ascolto per eventuali cambiamenti che avvengono nella variabile Published del protocollo ObservableObject
    @StateObject private var vm = DiscoverViewModelImpl(service: aniApiServiceImpl())
    var bounds = UIScreen.main.bounds
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Discover")
                .foregroundColor(Color("white"))
                .font(.custom(FontsManager.Montserrat.semiBold, size: 24))
                    if(vm.discoverAnimeLists.count > 0){
                           VStack(alignment: .leading){
                                RoundedRectangle(cornerRadius: 10).overlay(
                                    AsyncImage(url: URL(string: vm.discoverAnimeLists[0].images.jpg.image_url ?? "" )!, placeholder: {
                                        Color.black
                                    }, image: {image in Image(uiImage: image).resizable()}).cornerRadius(10)
                                )
                                    .frame(width: bounds.size.width-50, height: 200)
                                Text(vm.discoverAnimeLists[0].title).font(.custom(FontsManager.Montserrat.semiBold, size: 17)).foregroundColor(Color("white")).frame(width: bounds.size.width-60,height: 80, alignment: .top).lineLimit(2)
                            }
                        }

        }
            .onAppear(){
                    Task{
                        await vm.getAnimeList()
                }
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
