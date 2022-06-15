//
//  ContentView.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 03.06.2022.
//

import SwiftUI


// BETTER APPROACH
//use bindings
//multiple .sheet
//use $item

struct ContentView: View {
    
//    @State private var selectedModel: RandomModel = RandomModel(title: "Start screen")
    @State private var selectedModel: RandomModel?

//    @State private var showSheet: Bool = false
//    @State private var showSheet2: Bool = false
    
    var body: some View {
        VStack {
            Button {
                selectedModel = RandomModel(title: "ONE")
//                showSheet.toggle()
            } label: {
                Text("Screen 1")
        }

                
            Button {
                selectedModel = RandomModel(title: "TWO")
//                showSheet.toggle()
            } label: {
                Text("Screen 2")
            }
            
        }
        .sheet(item: $selectedModel) { model in
            NextScreen(randomModel: model)
        }
//        .sheet(isPresented: $showSheet) {
//            NextScreen(randomModel: selectedModel)
        }
    }


struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct NextScreen: View {
//   @Binding var randomModel: RandomModel
    var randomModel: RandomModel
    
    var body: some View {
        Text(randomModel.title)
            .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
