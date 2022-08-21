//
//  AnimeGenreList.swift
//  AnimeWatch
//
//  Created by Andrea on 11/06/22.
//

import SwiftUI

struct AllGenresScreen: View {
    
    
    @StateObject var dataSource = GetAllGenresDataSource()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        BackButton()
        
    }
    }
    
    var title : some View {
        Title(title: "Genres")
    }
    
    
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItemLayout, spacing: 15) {
                ForEach(dataSource.items, id: \.id) { genre in
                    NavigationLink(destination: AnimeGenreList(Genre_id: genre.id, Genre_title: genre.attributes.title)){
                        VStack{
                            Text(genre.attributes.title).font(.custom(FontsManager.Montserrat.black, size: 18)).foregroundColor(Color(.white))
                        }.frame(width: 170, height: 100)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("lightOrange"),Color("darkOrange")]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .onAppear(){
                            dataSource.loadMoreContentIfNeeded(currentItem: genre)
                        }
                    }
                }
            }
            if dataSource.isLoadingPage {
              ProgressView()
            }
        }
        .onAppear(){
            dataSource.loadMoreContent()
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack, trailing: title)
    }
}
