//
//  BackgroundBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 21.06.2022.
//

import SwiftUI


class BackgroundViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        //by selecting a Quality of Service class you can prioritise and specify thread to the some work
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("CHECK1: \(Thread.isMainThread)")
            print("CHECK1: \(Thread.current)")
            
            //When you update your UI you should do it on the main thread
            //Switch the work to the main thread by this code
            DispatchQueue.main.async {
                self.dataArray = newData
                print("CHECK2: \(Thread.isMainThread)")
                print("CHECK2: \(Thread.current)")
            }
           
        }
       
    }
    
    func downloadData() -> [String] {
        
        var data: [String] = []
        
        for i in 0..<100 {
            print("\(i)")
            data.append("\(i)")
        }
        return data
    }
}

struct BackgroundBootcamp: View {
    
    @StateObject var vm = BackgroundViewModel()
    
    
    var body: some View {
        ScrollView{
            VStack{
                Text("load data")
                    .textCase(.uppercase)
                    .font(.title)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id:\.self) { data in
                    Text(data)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundBootcamp()
    }
}
