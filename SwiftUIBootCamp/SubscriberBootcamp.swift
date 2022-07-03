//
//  SubscriberBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 26.06.2022.
//

import SwiftUI
import Combine

class SubscriberBootcampViewModel: ObservableObject {
    
    @Published var count: Int = 0
    @Published var countText: Int = 0
    
    var timer: AnyCancellable?
    
    //in case if we have a bunch of cancellable objects
    var cancellables = Set<AnyCancellable>()
    
    @Published var texFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextfieldSubscriber()
        addButtonSubscriber()
    }
    
    
    func addTextfieldSubscriber() {
        $texFieldText
        //wait 0.5 second before executing .map. For com;ex logic.  resource safety
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
//                guard let self = self else { return }
                
                if isValid && count >= 2  {
                    self?.showButton = true
                } else {
                    self?.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    
    func setUpTimer() {
        //for one cancellable
        //timer =
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                
                guard let self = self else { return }
                self.count += 1
                
                if self.count >= 10 {
                    
                    self.timer?.cancel()
                    
//                    //for all publishers
//                    for cancellable in self.cancellables {
//                        cancellable.cancel()
//                    }
//
                    
                }
            }
        //for mane cancellables
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberBootcampViewModel()
    
    var body: some View {
        VStack{
            Text("\(vm.count)")
            
            Text(vm.textIsValid.description)
                
            
            TextField("Type something here", text: $vm.texFieldText)
                .padding(.leading)
                .frame(height: 55)
                .background(.gray.opacity(0.3))
                .cornerRadius(15)
                .padding()
                .overlay(
                    ZStack{
                        Image(systemName: vm.textIsValid ? "checkmark" : "xmark")
                            .foregroundColor(vm.textIsValid ? .green : .red)
                        
                    }
                        .font(.headline)
                        . padding(.trailing, 30) , alignment: .trailing
                )
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .opacity(vm.showButton ? 1.0 : 0.5)
                    .disabled(!vm.showButton)
            }
          
            .padding()

        }
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
