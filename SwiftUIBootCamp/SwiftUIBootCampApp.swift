//
//  SwiftUIBootCampApp.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 03.06.2022.
//

import SwiftUI

@main
struct SwiftUIBootCampApp: App {
    var body: some Scene {
        WindowGroup {
            BigMountainsFriendCoreData()
                .environment(\.managedObjectContext, FriendsContainer(forPreview: false).persistentContainer.viewContext)
        }
        
    }
}
