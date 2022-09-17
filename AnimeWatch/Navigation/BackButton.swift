//
//  NavigationBar.swift
//  AnimeWatch
//
//  Created by Andrea on 15/08/22.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        ZStack{
            Image(systemName: "arrow.left")
            // .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .background(.regularMaterial,in: RoundedRectangle(cornerRadius: 40, style: .circular)).frame(width:30,height:30)
        }.padding(.leading, 10)
        }
        
    }
