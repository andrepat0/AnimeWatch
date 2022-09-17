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
                       ZStack{
                           Image(systemName: "xmark")
                               .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 20, height: 20)
                                     .font(.headline)
                                     //.foregroundColor(.white)
                                     .padding()
                       }.background(.regularMaterial,in: RoundedRectangle(cornerRadius: 40, style: .circular))
               }
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
            .navigationBarItems(trailing: btnBack)
    }
}


