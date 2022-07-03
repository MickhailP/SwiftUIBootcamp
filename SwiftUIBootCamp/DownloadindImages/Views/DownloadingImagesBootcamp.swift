//
//  DownloadingImagesBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 02.07.2022.
//

import SwiftUI

//Codable
//Backgrounds threads
// weak self
//Combine
//Publishers and subscribers
//FileManager
//NSCache

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImageRowView(model: model)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Downloading images")
        }
    }
}

struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
