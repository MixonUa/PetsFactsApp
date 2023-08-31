//
//  CatFact+CoreDataClass.swift
//  
//
//  Created by Михаил Фролов on 25.08.2023.
//
//

import Foundation
import CoreData

@objc(CatFact)
public class CatFact: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatFact> {
        return NSFetchRequest<CatFact>(entityName: "CatFact")
    }

    @NSManaged public var color: String?
    @NSManaged public var fact: String?
    @NSManaged public var likes: Int64
    @NSManaged public var name: String?

}
