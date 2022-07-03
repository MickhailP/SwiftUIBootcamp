//
//  ImageLoadingViewModel.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 02.07.2022.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    
    let manager = PhotoModelCacheManager.shared
    
    let urlString: String
    let imageKey: String
    
    var cancellables = Set<AnyCancellable>()
    
    init(url: String, key: String) {
        self.urlString = url
        self.imageKey = key
        getImage()
    }
    
    func getImage() {
        if let image = manager.get(key: imageKey) {
            self.image = image
            print("Getting saved image!")
        } else  {
            downloadImage()
            print("Downloading image!")
        }
    }
    
    func downloadImage() {
        print("Downloading images now")
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
        //BETTER APPROACH
            .map { UIImage(data: $0.data )}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard
                    let self = self,
                    let image = returnedImage else { return
                }
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
                
            }
            .store(in: &cancellables)
//            .map { (data, response) -> UIImage? in
//                return UIImage(data: data)
//            }
    }
}
