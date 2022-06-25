//
//  DownloadWithCombine.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 25.06.2022.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts() 
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        
        //Combine Discussion
        /*
        //1.Sing up for a subscription
        //2. The company would make the delivery
        //3. recieve the package
        //4.  make sure the box isn't damaged
        //5. open and make sure that it is that you want
        //6. use item.
        //7. cancellable at any time
        
        
        //1. create the publisher (by default)
        //2. put it on the background
        //3. receive on the main
        //4. tryMap() (check that data is good
        //5. decode in Model
        //6. sink (put the item in to our app
        //7. store (cancel subscription)
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
        //.subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
        
        //            .tryMap { (data, response) -> Data in
        //                guard let response = response as? HTTPURLResponse,
        //                response.statusCode >= 200 && response.statusCode < 300 else{
        //                    throw URLError(.badServerResponse)
        //                }
        //                return data
        //            }
        //BETTER SOLUTION
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            //handle errors this way to write more shorter .sink
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
//            .sink { (completion) in
//                print("COMPLETION: \(completion)")
//
//                switch completion {
//                    case .finished:
//                        print("FINISHED")
//                    case .failure(let error):
//                        print("There was an error: \(error)")
//                }
//
//            } receiveValue: { [weak self] (returnedPosts)  in
//                self?.posts = returnedPosts
//            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else{
            throw URLError(.badServerResponse)
        }
        return output.data
    }
} 

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack {
                    Text(post.title)
                }
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
