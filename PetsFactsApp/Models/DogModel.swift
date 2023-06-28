//
//  DogModel.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 25.06.2023.
//

import Foundation

struct DogModel: Codable {
    let name : String
    let fact: String
    let color: String
    let likes: Int
}
