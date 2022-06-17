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
        self.container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load core data. \(error)")
            }
        }
        self.context = container.viewContext
    }
    
    
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var businesses: [Business] = []
    
    init() {
        getData()
    }
    
    func getData() {
        let request = NSFetchRequest<Business>(entityName: "Business")
        
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Fetching error. \(error)")
        }
    }
    
    func addBusiness() {
        let newBusiness = Business(context: manager.context)
        newBusiness.name = "Apple"
        saveData()
    }
    
    func saveData() {
        do {
            try  manager.context.save()
            print("Successfully saved")
        } catch {
            print("Failed to save data. \(error)")
        }
    }
    
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    Button {
                        vm.addBusiness()
                    } label: {
                        Text("Add new business")
                            .padding()
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 30)
                            .frame(maxWidth: .infinity)
                            .background(.indigo)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 10) {
                            ForEach(vm.businesses) { business in
                                BusinessView(business: business)
                            }
                        }
                    }

                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct BusinessView: View {
    
    let business: Business
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(business.name ?? "Unknown")
                .bold()
            
            if let departments = business.departments?.allObjects as? [Department] {
                Text("Departments: ")
                    .fontWeight(.bold)

                ForEach(departments) { department in
                    Text(department.name ?? "Unknown department")
                }
            }
            
            if let employees = business.employees?.allObjects as? [Employee] {
                Text("Employees: ")
                    .fontWeight(.bold)
                ForEach(employees) { employee in
                    Text(employee.name ?? "Unknown eployee")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.gray.opacity(0.3))
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}


struct CoreDataRelationshipsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBootcamp()
    }
}
