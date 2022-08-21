//
//  TabBarItemPreferenceKey.swift
//  AnimeWatch
//
//  Created by Andrea on 21/08/22.
//

import Foundation
import SwiftUI


struct TabBarItemPreferenceKey: PreferenceKey {
    
    static var defaultValue: [TabBarItem] = []
    
    /* Aggiunge ogni nuovo tab passato come parametro al array */
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier: ViewModifier {
    
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    
    /* Aggiorna la nostra preference key */
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemPreferenceKey.self, value: [tab])
    }
}


extension View {
    func tabBarItem(tab: TabBarItem,selection: Binding<TabBarItem>) -> some View {
        self
            .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
