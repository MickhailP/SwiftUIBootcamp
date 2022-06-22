//
//  EscapingView.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 22.06.2022.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
        
        downloadData3 { [weak self] returnedData in
            self?.text = returnedData
        }
        
        downloadData4 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
        
        downloadData5 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
        
        // let newData = downloadData2()
        //text = newData
    }
    
    func downloadData() -> String {
        return "New data"
    }
    func downloadData2(completionHandler: (_ data: String) -> Void){
        completionHandler("new data")
    }
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("new data")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "Downloaded data")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "Downloaded data")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> Void

struct EscapingView: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text("Hello")
    }
}

struct EscapingView_Previews: PreviewProvider {
    static var previews: some View {
        EscapingView()
    }
}
