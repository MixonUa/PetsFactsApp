//
//  CoreDataManager.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 02.07.2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    private let dataManager: NetworkDownloadManager
    init(networkDownloadManager: NetworkDownloadManager = NetworkDownloadManager()) {
        dataManager = networkDownloadManager
    }
    
    private var appDelegate: AppDelegate { UIApplication.shared.delegate as! AppDelegate }
    private var context: NSManagedObjectContext { appDelegate.persistentContainer.viewContext }
    
    public func saveData() {
        dataManager.downloadData { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        if let catData = dataManager.catData {
            catData.forEach { (data) in
                saveCatData(catData: data)
                print(catData)
            }
        }
        if let dogData = dataManager.dogData {
            dogData.forEach { (data) in
                saveDogData(dogData: data)
            }
        }
    }
    
    private func saveCatData(catData: CatModel) {
        guard let entity = NSEntityDescription.entity(forEntityName: "CatFact", in: context) else { return }
        let catFact = CatFact(entity: entity, insertInto: context)
        catFact.name = catData.name
        catFact.fact = catData.fact
        appDelegate.saveContext()
        print("Cat data saved")
    }
    private func saveDogData(dogData: DogModel) {
        guard let entity = NSEntityDescription.entity(forEntityName: "DogFact", in: context) else { return }
        let dogFact = CatFact(entity: entity, insertInto: context)
        dogFact.name = dogData.name
        dogFact.fact = dogData.fact
        appDelegate.saveContext()
        print("Dog data saved")
    }
    
    public func deleteData() {
        let catFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatFact")
        do {
            let cats = try? context.fetch(catFetchRequest) as? [CatFact]
            cats?.forEach({ context.delete($0) })
        }
        let dogFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogFact")
        do {
            let dogs = try? context.fetch(dogFetchRequest) as? [DogFact]
            dogs?.forEach({ context.delete($0) })
        }
        appDelegate.saveContext()
    }
    
    public func fetchCatData() -> [CatFact] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatFact")
        do {
            return try context.fetch(fetchRequest) as! [CatFact]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    public func fetchDogData() -> [DogFact] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogFact")
        do {
            return try context.fetch(fetchRequest) as! [DogFact]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}
