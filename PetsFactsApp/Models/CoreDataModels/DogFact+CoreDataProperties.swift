//
//  DogFact+CoreDataProperties.swift
//  
//
//  Created by Михаил Фролов on 02.07.2023.
//
//

import Foundation
import CoreData

@objc(DogFact)
public class DogFact: NSManagedObject {}

extension DogFact {
    @NSManaged public var name: String
    @NSManaged public var fact: String
    @NSManaged public var color: String?
    @NSManaged public var likes: Int64
}
