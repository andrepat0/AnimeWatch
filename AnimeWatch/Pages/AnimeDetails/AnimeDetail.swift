//
//  AnimeDetail.swift
//  AnimeWatch
//
//  Created by Andrea on 24/04/22.
//

import SwiftUI
import WebKit


struct AnimeDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
       var btnBack : some View { Button(action: {
           self.presentationMode.wrappedValue.dismiss()
           }) {
               HStack{
                   LinearGradient(gradient: Gradient(colors: [Color("lightOrange"),Color("darkOrange")]), startPoint: .top, endPoint: .bottom).mask(
                       Image(systemName: "arrow.left")
                           .aspectRatio(contentMode: .fit)
                   ).frame(width: 25, height:40)
                       .padding(.leading, 10)
                   Text("Home")
                       .font(.custom(FontsManager.Montserrat.regular, size: 12))
                       .padding(.trailing, 10)
               }.background(.regularMaterial,in: RoundedRectangle(cornerRadius: 20, style: .circular))
                   .ignoresSafeArea()
               Spacer()
           }
       }
    
    var data: Attributes?
    
    init(data: Attributes?){
        self.data = data
    }
    
    var body: some View {
            HorizontalTabView(data: data!)
        .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
    }
}


