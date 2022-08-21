//
//  GeneralDetailScreen.swift
//  AnimeWatch
//
//  Created by Andrea on 16/07/22.
//

import SwiftUI


struct GeneralDetailScreen: View {
    
    var data: Attributes;
    var bounds = UIScreen.main.bounds;
    var averageRating = 0.0
    
    init(data: Attributes){
        self.data = data
        self.averageRating = Double(data.attributes.averageRating) ?? 0.0
    }
    
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
    
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading){
                ScrollView(showsIndicators: true){
                    Text("\(data.attributes.synopsis ?? "")")
                    .font(.custom(FontsManager.Montserrat.regular, size: 15))
                }.padding([.bottom,.leading,.trailing])
            }.frame(height: 250)
            Spacer()
            VStack(alignment: .leading){
                Text("Trailer")
                    .foregroundColor(Color("white"))
                    .font(.custom(FontsManager.Montserrat.semiBold, size: 22))
                    .padding(.leading, 15)
                YoutubeVideoView(videoId: data.attributes.youtubeVideoId ?? "").cornerRadius(10)
                    .padding([.bottom,.leading,.trailing])
            }.frame(height: 250)
        }
.cornerRadius(40, corners: [.topLeft, .topRight])
    }
}
