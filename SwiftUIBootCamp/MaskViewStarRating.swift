//
//  MaskViewStarRating.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 07.06.2022.
//

import SwiftUI

struct MaskViewStarRating: View {
    
    @State private var rating: Int = 2
    
    var body: some View {
        ZStack {
            starsView
                .overlay(overlayLayer.mask(starsView))
        }
    }
    
    var overlayLayer: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geo.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    var starsView: some View {
        HStack{
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                       
                    }
            }
        }
    }
}

struct MaskViewStarRating_Previews: PreviewProvider {
    static var previews: some View {
        MaskViewStarRating()
    }
}
