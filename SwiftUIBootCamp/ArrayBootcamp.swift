//
//  ArrayBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 13.06.2022.
//

import Foundation
import SwiftUI

struct User: Identifiable {
    let id = UUID()
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ViewModel: ObservableObject {
    @Published var dataArray: [User] = []
    @Published var filteredArray: [User] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        //sort
        //filtered
        //map
        
        //SORTED FUNCTION
        /*
//        filteredArray = dataArray.sorted { user1, user2 in
//            return user1.points > user2.points
//        }
//        //The shorter way to write sorting function
//        filteredArray = dataArray.sorted(by: { $0.points < $1.points})
//
         */
        
        //FILTER FUNCTION
        /*
        filteredArray = dataArray.filter({ user in
            return user.points > 22
        })
        
        filteredArray = dataArray.filter( { $0.name.contains("a") })
         */
        
        //MAP
        /*
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name
//        })
//
//        mappedArray = dataArray.map( { $0.name })
         */
        
        //COMPACTMAP uses for optionals data. Automatically unwrap optionals
        /*
        //if the value will be nil it automatically skip this value without error
        mappedArray = dataArray.compactMap({ (user) -> String? in
            return user.name
        })
        
        mappedArray = dataArray.compactMap( { $0.name })
         */
        
        mappedArray = dataArray
            .sorted(by: { $0.points > $1.points})
            .filter({ $0.isVerified })
            .compactMap({ $0.name })
        
    }
    
    func getUsers() {
        let user1 = User(name: nil, points: 22, isVerified: false)
        let user2 = User(name: "Jane", points: 100, isVerified: false)
        let user3 = User(name: "Dwait", points: 1, isVerified: true)
        let user4 = User(name: nil, points: 10, isVerified: true)
        let user5 = User(name: "Jim", points: 544, isVerified: false)
        let user6 = User(name: "Andy", points: 23, isVerified: true)
        
        let temp = [user1, user2, user3, user4, user5, user6]
        self.dataArray.append(contentsOf: temp)
    }
}

struct ArrayBootcamp: View {
    
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading){
//                        Text(user.name)
//                        HStack {
//                            Text("Points: \(user.points)")
//                                .font(.headline)
//                            Spacer()
//
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.indigo.cornerRadius(10))
//                    .padding(.horizontal)
//                }
                ForEach(vm.mappedArray, id:\.self) { name in
                    Text(name)
                        .font(.title)
                }
            }
        }
    }
}


struct ArrayBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArrayBootcamp()
    }
}
