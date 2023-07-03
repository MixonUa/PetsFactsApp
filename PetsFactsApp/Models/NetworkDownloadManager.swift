//
//  NetworkDownloadManager.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 03.07.2023.
//

import Foundation

class NetworkDownloadManager {
    public var catData: [CatModel]?
    public var dogData: [DogModel]?
    
    private let networkFetchService: NetworkFetchService
    
    init(networkFetchService: NetworkFetchService = NetworkFetchService()) {
        self.networkFetchService = networkFetchService
    }
    
    public func downloadData(completion: @escaping (Error?) -> Void) {
        let group = DispatchGroup()
        var error: Error?
        
        group.enter()
        networkFetchService.requestCatData { [weak self](data, catError) in
            if error == nil {
                error = catError
            }
            if let data = data {
                self?.catData = data
            }
            group.leave()
        }
        group.enter()
        networkFetchService.requestDogData { [weak self](data, dogError) in
            if error == nil {
                error = dogError
            }
            if let data = data {
                self?.dogData = data
            }
            group.leave()
        }
        group.notify(queue: .main) {
            completion(error)
        }
    }
}
