//
//  DownloadWithEscaping.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 23.06.2022.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts = [PostModel]()

     
    init() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        getPost()
        downloadData(from: url) { data in
            if let data = data {
                guard let decodedData = try? JSONDecoder().decode(PostModel.self, from: data) else { return }

                DispatchQueue.main.async { [weak self] in
                    self?.posts.append(decodedData)

                }
            } else {
                print("No data returned!")
            }
        }
    }
    
    func getPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                print("No Data!")
                return
            }
            
            guard error == nil else {
                print("There was an error: \(String(describing: error))")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }

            
            guard response.statusCode >= 200 && response.statusCode < 300  else {
                print("There should be a code 2xx, but it is \(response.statusCode)")
                return
            }
            
            print("Data successfully downloaded")
            
            guard let decodedData = try? JSONDecoder().decode(PostModel.self, from: data) else { return }

            DispatchQueue.main.async { [weak self] in
                self?.posts.append(decodedData)

            }
        }.resume()
    }
    
    func downloadData(from url: URL, completionHandler: @escaping (_ data: Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                print("No Data!")
                completionHandler(nil)

                return
            }
            
            guard error == nil else {
                print("There was an error: \(String(describing: error))")
                completionHandler(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response")
                completionHandler(nil)
                return
            }

            
            guard response.statusCode >= 200 && response.statusCode < 300  else {
                print("There should be a code 2xx, but it is \(response.statusCode)")
                completionHandler(nil)
                return
            }
            
            print("Data successfully downloaded")
            
            completionHandler(data)
            
        }.resume()
    }
}

struct DownloadWithEscaping: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts) {post in
                Text(post.title)
            }
        }
    }
}

struct DownloadWithEscaping_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscaping()
    }
}
