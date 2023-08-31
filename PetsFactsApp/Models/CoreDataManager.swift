//
//  CoreDataManager.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 02.07.2023.
//

import Foundation
import UIKit
import CoreData

public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init() {}
    
    private var appDelegate: AppDelegate { UIApplication.shared.delegate as! AppDelegate }
    private var context: NSManagedObjectContext { appDelegate.persistentContainer.viewContext }
    
    public func saveCatFact(name: String, fact: String, color: String, likes: Int64) {
        guard let catFactEntityDescription = NSEntityDescription.entity(forEntityName: "CatFact", in: context) else { return }
        let catFact = CatFact(entity: catFactEntityDescription, insertInto: context)
        catFact.name = name
        catFact.fact = fact
        catFact.color = color
        catFact.likes = likes

        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    
    public func fetchAllCatFacts() -> [CatFact] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatFact")
        do {
            return (try? context.fetch(fetchRequest) as? [CatFact]) ?? []
        }
    }
    
    public func fetchCatFact(name: String) -> CatFact? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatFact")
        do {
            let catFact = try? context.fetch(fetchRequest) as? [CatFact]
            return catFact?.first(where: { $0.name == name})
        }
    }



    public func deleteAllCatFacts() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatFact")
        do {
            let catFact = try? context.fetch(fetchRequest) as? [CatFact]
            catFact?.forEach {context.delete($0)}
        }
        appDelegate.saveContext()
    }
}
