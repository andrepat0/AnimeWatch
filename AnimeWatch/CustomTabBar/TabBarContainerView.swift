//
//  TabBarContainerView.swift
//  AnimeWatch
//
//  Created by Andrea on 21/08/22.
//

import Foundation
import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0){
            AppTabBarView(tabs: tabs, selection: $selection)
                .offset(y: -83)
            ZStack{
                content
                    .offset(y:-63)
            }
        }
        .onPreferenceChange(TabBarItemPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}
