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
    
    func saveData() {
        do {
            try  context.save()
            print("Successfully saved")
        } catch {
            print("Failed to save data. \(error)")
        }
    }
    
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var businesses: [Business] = []
    @Published var departments: [Department] = []
    @Published var employees: [Employee] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<Business>(entityName: "Business")
        
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Fetching error. \(error)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<Department>(entityName: "Department")
        
        do {
            departments = try manager.context.fetch(request)
        } catch {
            print("Fetching error. \(error)")
        }
    }
    
    
    func getEmployees() {
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Fetching error. \(error)")
        }
    }
    
    
    func addBusiness() {
        let newBusiness = Business(context: manager.context)
        newBusiness.name = "Microsoft"
        
        //add existing departments to the new business
        newBusiness.departments = [departments[0], departments[1]]
        
        //add existing employees to the new business
        newBusiness.employees = [employees[4]]
        
        //add a new business to the existing department
        //newBusiness.addToDepartments(<#T##value: Department##Department#>)
        
        //add a new business to the existing employee
        //newBusiness.addToEmployees(<#T##value: Employee##Employee#>)
        
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = Department(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        newDepartment.addToEmployees(employees[4])
        
        newDepartment.addToEmployees(employees[4])
        save()
    }
    
    func addEmployee() {
        let newEmployee = Employee(context: manager.context)
        newEmployee.name = "Angela"
        newEmployee.age = 35
        newEmployee.dateJoined = Date()
        
        
//        newEmployee.business = businesses[0]
        
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.manager.saveData()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
            
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
//                        vm.addBusiness()
                        vm.addDepartment()
//                        vm.addEmployee()
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
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 10) {
                            ForEach(vm.businesses) { business in
                                BusinessView(business: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 10) {
                            ForEach(vm.departments) { department in
                                DepartmentView(department: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 10) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(employee: employee)
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

struct DepartmentView: View {
    
    let department: Department
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(department.name ?? "Unknown")
                .bold()
            
            if let businesses = department.businesses?.allObjects as? [Business] {
                Text("Business: ")
                    .fontWeight(.bold)

                ForEach(businesses) { business in
                    Text(business.name ?? "Unknown business")
                }
            }
            
            if let employees = department.employees?.allObjects as? [Employee] {
                Text("Employees: ")
                    .fontWeight(.bold)
                ForEach(employees) { employee in
                    Text(employee.name ?? "Unknown eployee")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.green.opacity(0.3))
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let employee: Employee
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(employee.name ?? "Unknown")
                .bold()
            
            Text("Age \(employee.age )")

            Text("Date joined: \(employee.dateJoined ?? Date())")
            
            
            Text("Business: ")
                .fontWeight(.bold)
            
            Text(employee.business?.name ?? "Unknown")
            
            Text("Department: ")
                .fontWeight(.bold)
            
            Text(employee.department?.name ?? "Unknown")

           
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.blue.opacity(0.3))
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}




struct CoreDataRelationshipsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBootcamp()
    }
}
