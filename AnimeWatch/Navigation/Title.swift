//
//  Title.swift
//  AnimeWatch
//
//  Created by Andrea on 15/08/22.
//

import SwiftUI

struct Title: View {
    var title = "";
    var body: some View {
        ZStack{
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
            
            Text(title)
                .font(.custom(FontsManager.Montserrat.bold, size: 26))
                .fixedSize(horizontal: true, vertical: true)
                .padding(10)
            
        }.padding(.trailing,10)
    }
}

