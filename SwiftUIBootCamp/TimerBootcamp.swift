//
//  TimerBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 25.06.2022.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    //Current time
    /*
     @State var currentDate: Date = Date()
     var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     formatter.timeStyle = .medium
     return formatter
     }
     */
    
    //Countdown
//    @State var count: Int = 10
//    @State var finishedText: String? = nil
    
    //Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        let hour = remaining.hour ?? 0
        timeRemaining = "\(hour): \(minute): \(second)"
    }
    */
    
    //Animation counter
    
    
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.pink.opacity(0.6), .white, .indigo.opacity(0.8)]), center: .center, startRadius: 10, endRadius: 300)
                .ignoresSafeArea()
            
//            “Text(dateFormatter.string(from: currentDate))
//            Text(finishedText ?? "\(count)")
//            Text(timeRemaining)
//                .font(.system(size: 50, weight: .bold, design: .rounded))
//                .foregroundColor(.white)
//                .shadow(color: .gray, radius: 10)
//            
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? 20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? 20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? 20 : 0)
//            }
//            .shadow(radius: 5)
//            .frame(width: 150)
//            .foregroundColor(.white)
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.yellow)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.mint)
                    .tag(5)
            }
            .frame(height: 200)
            .tabViewStyle(.page)
        }
        
        //        .onReceive(timer) { value in
        //            currentDate = value
        //        }
        
        //        .onReceive(timer) { _ in
        //            if count < 1 {
        //                finishedText = "Wow!"
        //            } else {
        //                count -= 1
        //            }
        //        .onReceive(timer) { _ in
        //            updateTimeRemaining()
        //        }
//        .onReceive(timer) { _ in
//            withAnimation(.easeInOut(duration: 0.8)) {
//                count = count == 3 ? 0 : count + 1
//            }
//        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                count = count == 5 ? 0 : count + 1
            }
        }
    }
}


struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
