//
//  WeakSelfBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 21.06.2022.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView{
            NavigationLink("Second screen") {
                WeakSecondScreen()
                    .navigationTitle("Screen 1")
            }
            
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.title)
                .padding()
                .background(.orange)
                .cornerRadius(20)
            , alignment: .topTrailing
        )
    }
}

struct WeakSecondScreen: View {
    
    @StateObject var vm = WeakSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("SECOND SCREEN")
                .font(.largeTitle)
                .foregroundColor(.indigo)
            
            if let data = vm.data {
                Text(data)
                    .font(.headline)
            }
        }
    }
}

class WeakSecondScreenViewModel: ObservableObject {
    
    @Published var data: String?  = nil
    
    init() {
        print("INITIALISED")
        
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1 , forKey: "count")
        
        getData()
    }
    
    deinit {
        print("DEINITIALISED")
        
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1 , forKey: "count")
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            self?.data = "NEW DATA!!!"
        }
    }
}

struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}
