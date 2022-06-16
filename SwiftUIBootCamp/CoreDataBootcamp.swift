//
//  CoreDataBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Миша Перевозчиков on 15.06.2022.
//

import CoreData
import SwiftUI

class CoreDataViewModel: ObservableObject  {
    let container: NSPersistentContainer
    
    @Published var savedEntities: [Fruit] = []
    
    init() {
        self.container = NSPersistentContainer(name: "FruitsContainer")
        self.container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Core Data loaded successfully!")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let fetchRequest = NSFetchRequest<Fruit>(entityName: "Fruit")
        
        do {
           savedEntities =  try container.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error fetching \(error)")
        }
    }
    
    func addFruit(name: String) {
        let newFruit = Fruit(context: container.viewContext)
        newFruit.name = name
        saveData()
    }
    
    func deleteData(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let fruit = savedEntities[index]
        container.viewContext.delete(fruit)
        saveData()
    }
    
    func updateFruit(fruit: Fruit) {
        let currentName = fruit.name
        
        let newName = currentName + "!"
        fruit.name = newName
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch {
            print("Failed to save data")
        }
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    @State private var newFruitField = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 10){
                TextField("Add new fruits...", text: $newFruitField)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(12)
                    .padding(.horizontal)
                Button {
                    guard !newFruitField.isEmpty else { return }
                    vm.addFruit(name: newFruitField)
                    newFruitField = ""
                } label: {
                    Text("Add")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(.indigo.opacity(0.8))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                }
                Spacer()
                
                List{
                    ForEach(vm.savedEntities, id:\.self) { fruit in
                        Text(fruit.name ?? "Unknown")
                            .onTapGesture {
                                vm.updateFruit(fruit: fruit)
                            }
                        
                    }
                    .onDelete(perform: vm.deleteData)
                    
                }
                .listStyle(.plain)
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
