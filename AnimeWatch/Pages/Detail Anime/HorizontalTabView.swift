//
//  HorizontalTabView.swift
//  AnimeWatch
//
//  Created by Andrea on 14/05/22.
//

import SwiftUI

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct HorizontalTabView: View {
    
    /* Variabili di stato */
    @State private var selection: String = "Trama"
    @State private var tabSelection: TabBarItem = TabBarItem(title: "Trama")
    
    var data: Attributes
    var averageRating: Double
    var bounds = UIScreen.main.bounds
    
    init(data: Attributes){
        self.data = data
        self.averageRating = Double(self.data.attributes.averageRating ?? "0") ?? 0.0
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                VStack{
                    
                    VStack(alignment: .leading){
                    }.frame(width: (bounds.size.width), height: 380)
                        .background(AsyncImage(url: URL(string: (data.attributes.posterImage.medium) ?? "")!, placeholder: {
                            Color.black
                        }, image: {image in Image(uiImage: image).resizable()}))
                    
                    /*  Tab Trama */
                    CustomTabBarContainerView(selection: $tabSelection){
                        
                        Trama(data: self.data, averageRating: averageRating, Selection: tabSelection)
                                .tabBarItem(tab: TabBarItem(title: "Trama"), selection: $tabSelection)
                        
                        Episodes(data: self.data, Selection: tabSelection)
                            .tabBarItem(tab: TabBarItem(title: "Episodes"), selection: $tabSelection)
                           // .transition(.move(edge: .bottom))
                        
                        Relateds(data: self.data, Selection: tabSelection)
                            .tabBarItem(tab: TabBarItem(title: "Related"), selection: $tabSelection)
                    }
                }
            }
           /* .onAppear(){
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.showAnimeDetail = true
                }
        }*/
        }
        .ignoresSafeArea()
    }
}
