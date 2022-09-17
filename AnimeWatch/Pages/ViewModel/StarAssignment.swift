//
//  StarAssignment.swift
//  AnimeWatch
//
//  Created by Andrea on 21/08/22.
//

import Foundation
import SwiftUI

func StarAssignment(score: Double) -> Image {
    
    switch score {
    case 0...40:
        return Image("StarSemiHalf")
    case 40...60:
        return Image("StarHalf")
    case 60...80:
        return Image("StarOverHalf")
    case 80...100:
        return Image("FullStar")
    default:
        return Image("")
        
    }
    
}
