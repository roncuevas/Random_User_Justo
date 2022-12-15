//
//  CoreDataManager.swift
//  RandomUser4Justo
//
//  Created by user218634 on 8/27/22.
//

import Foundation
import CoreData

class CoreDataManager {
    private let container: NSPersistentContainer
    @Published var savedEntities: [UserEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "UsersContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            } else {
                print("Succesfully loaded core data")
            }
        }
        fetchUsers()
    }
    
    func fetchUsers() {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching data \(error)")
        }
    }
    
    func clearAll() {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Error cleaning the data: \(error)")
        }
    }
    
    func addUser(name: String, header: String, data: String, url: String) {
        let newUser = UserEntity(context: container.viewContext)
        newUser.name = name
        newUser.header = header
        newUser.data = data
        newUser.url = url
        saveData()
    }
    
    func deleteUserIndex(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func deleteUser(entity: UserEntity) {
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchUsers()
        } catch let error {
            print("Error saving data: \(error)")
        }
        
    }
}
