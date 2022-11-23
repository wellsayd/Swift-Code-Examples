//
//  RatingStars.swift
//  VB ParkFinder
//
//  Created by bwells on 11/21/22.
//

import SwiftUI

struct RatingStars: View {
    
    var rating: Double
    var wholeNum: Int
    var remainderNum: Double
    
    init(rating: Double, wholeNum: Int, remainderNum: Double){
        self.rating = rating
        self.wholeNum = wholeNum
        self.remainderNum = remainderNum
    }

    var body: some View {
        HStack()
        {
            if(rating > 0){
                Text(String(rating))
                ForEach(0..<wholeNum, id: \.self) { i in
                    Image("star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20.0, height: 20.0, alignment: .top)
                        .foregroundColor(.yellow)
                }
                if(remainderNum > 0.75){
                    Image("star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20.0, height: 20.0, alignment: .top)
                        .foregroundColor(.yellow)
                }
                
                if(remainderNum > 0.25 && remainderNum < 0.75) {
                    Image("star_half")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20.0, height: 20.0, alignment: .top)
                        .foregroundColor(.yellow)
                }
            } else {
                Text("No rating")
            }
        }
    }
}
