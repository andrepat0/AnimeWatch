//
//  ToolbarAnimeDetail.swift
//  AnimeWatch
//
//  Created by Andrea on 01/05/22.
//

import SwiftUI

struct ToolbarAnimeDetail: View{
    
    let tabs: [ToolbarItem]
    @State var selection:  ToolbarItem
    
    
    var body: some View{
        HStack{
            ForEach(tabs, id: \.self){ tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }.padding()
    }
}


extension ToolbarAnimeDetail {
    private func tabView(tab: ToolbarItem) -> some View {
            VStack{
                Image(systemName: tab.iconName)
                Text(tab.title).font(.custom(FontsManager.Montserrat.semiBold, size: 10)).padding(.top, 2)
            }
            .foregroundColor(selection == tab ?Color("white") : tab.color )
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(selection == tab ? Color("darkOrange") : tab.color.opacity(0.2))
            .cornerRadius(10)
        }
    
    private func switchToTab(tab: ToolbarItem){
        withAnimation(.easeInOut) {
            
        }
    }
}

struct ToolbarItem: Hashable{
    let iconName: String
    let title: String
    let color: Color
    
}

struct ToolbarAnimeDetail_Previews: PreviewProvider {
    
    static let tabs: [ToolbarItem] = [
        ToolbarItem(iconName: "book.fill", title: "Description", color: Color("darkOrange")),
        ToolbarItem(iconName: "play.fill", title: "Episodes", color: Color("darkOrange")),
        ToolbarItem(iconName: "paperclip", title: "Related", color: Color("darkOrange"))
    ]
    
    static var previews: some View {
        ToolbarAnimeDetail(tabs: tabs, selection: tabs.first!)
    }
}
