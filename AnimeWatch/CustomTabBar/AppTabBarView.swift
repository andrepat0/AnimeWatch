//
//  AppTabBarView.swift
//  AnimeWatch
//
//  Created by Andrea on 15/08/22.
//

import SwiftUI

struct AppTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    var body: some View {
        HStack{
            ForEach(tabs, id: \.self) { tab in
                tabView(tabItem: tab)
                    .onTapGesture {
                        switchToTab(TabItem: tab)
                    }
            }
        }.padding([.leading,.trailing],30)
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static let tabsExample : [TabBarItem] = [
        TabBarItem(title: "Trama"),
        TabBarItem(title: "Episodes"),
        TabBarItem(title: "Related")
    ]
    static var previews: some View {
        AppTabBarView(tabs: tabsExample, selection: .constant(tabsExample.first!))
    }
}

extension AppTabBarView {
     func tabView(tabItem: TabBarItem) -> some View {
        ZStack{
            if(selection == tabItem){
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color("lightOrange"),Color("darkOrange")]), startPoint: .top, endPoint: .bottom)
                    Text(tabItem.title)
                        .font(.custom(FontsManager.Montserrat.semiBold, size: 14))
                        .padding()
                        .foregroundColor(Color.white)
                }
            }else{
                Text(tabItem.title)
                    .font(.custom(FontsManager.Montserrat.semiBold, size: 14))
                    .padding()
                    .foregroundColor(Color.white)
                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 40, style: .circular))
                
            }
        }.frame(maxWidth: .infinity).cornerRadius(40).frame(height: 30)
    }
    
    func switchToTab(TabItem: TabBarItem) {
        selection = TabItem
    }
}

struct TabBarItem: Hashable {
    let title: String
}
