//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 16.06.2022.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager() //Singletone
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        self.container = NSPersistentContainer(name: "")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load core data. \(error)")
            }
        }
        self.context = container.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
            
        } catch {
            print("Failed to save data. \(error)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CoreDataRelationshipsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBootcamp()
    }
}
