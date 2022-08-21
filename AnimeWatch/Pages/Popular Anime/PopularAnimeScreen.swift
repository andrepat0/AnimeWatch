//
//  PopularAnimeScreen.swift
//  AnimeWatch
//
//  Created by Andrea on 17/03/22.
//

import SwiftUI

struct PopularAnimeScreen: View {
    //Stateobject permette alla variabile di restare in ascolto per eventuali cambiamenti che avvengono nella variabile Published del protocollo ObservableObject
    @StateObject private var vm = AnimeListViewModelImpl(service: jikanServiceImpl())
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Popular")
                .foregroundColor(Color("white"))
                .font(.custom(FontsManager.Montserrat.semiBold, size: 22))
                .fontWeight(.medium)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack{
                    ForEach(vm.animeLists,id: \.id){ anime in
                        PopularCardView(item:anime)
                            //.shadow(color: Color.black.opacity(0.2),radius:5,x: 5,y: 5)
                    }
                }
            }
                .task{
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
