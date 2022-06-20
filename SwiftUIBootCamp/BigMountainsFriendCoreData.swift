//
//  BigMountainsFriendCoreData.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 20.06.2022.
//

import CoreData
import SwiftUI


class FriendsContainer {
    let persistentContainer: NSPersistentContainer
    
    init(forPreview: Bool) {
        
        persistentContainer = NSPersistentContainer(name: "FriendsDataModel")
  
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load core data. \(error)")
            }
        }
        
    
    }
    
    static var preview: NSManagedObjectContext {
        get {
            let persistentContainer = NSPersistentContainer(name: "FriendsDataModel")
            //        «This means every time you run the app with forPreview set to true, it will always start over»
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
            persistentContainer.loadPersistentStores { description, error in
                if let error = error {
                    print("Failed to load core data. \(error)")
                }
            }
            addMockData(moc: persistentContainer.viewContext)
            
            return persistentContainer.viewContext

        }
    }
}

extension FriendsContainer {
   static func addMockData(moc: NSManagedObjectContext) {
        let friend1 = FriendEntity(context: moc)
        friend1.firstName = "Michael"
        friend1.lastName = "Perevozchikov"
        
        let friend2 = FriendEntity(context: moc)
        friend1.firstName = "Jim"
        friend1.lastName = "Halper"
        
        try? moc.save()
    }
}

struct BigMountainsFriendCoreData: View {
    @FetchRequest(sortDescriptors: []) var friends: FetchedResults<FriendEntity>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BigMountainsFriendCoreData_Previews: PreviewProvider {
    static var previews: some View {
        BigMountainsFriendCoreData()
            .environment(\.managedObjectContext, FriendsContainer.preview)
    }
}
