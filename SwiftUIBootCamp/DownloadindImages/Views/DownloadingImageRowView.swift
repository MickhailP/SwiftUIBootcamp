//
//  DownloadingImageRowView.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 02.07.2022.
//

import SwiftUI

struct DownloadingImageRowView: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack {
            DownloadingImageView(url: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)

            VStack {
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .font(.body)
                    .foregroundColor(.gray)
                    .italic()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    }
}

struct DownloadingImageRowView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageRowView(model: PhotoModel(albumId: 1, id: 1, title: "ADad", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "adafa"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
