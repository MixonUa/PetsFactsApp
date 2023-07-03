//
//  NetworkFetchService.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 25.06.2023.
//

import Foundation

class NetworkFetchService {
    private let networkManager : NetworkManagerAlamofire
    init(networkManager: NetworkManagerAlamofire = NetworkManagerAlamofire()) {
        self.networkManager = networkManager
    }
    
    func requestCatData(completion: @escaping ([CatModel]?, Error?) -> Void) {
        let catUrl = "https://raw.githubusercontent.com/MixonUa/JSON-Facts/main/cats.json"
        networkManager.requestData(url: catUrl) { (data, error) in
            guard let data = data else { return }
            do {
                let answer = try JSONDecoder().decode([CatModel].self, from: data)
                DispatchQueue.main.async {
                    completion(answer, nil)
                    }
                } catch (let decodingError) {
                    DispatchQueue.main.async {
                        completion(nil, decodingError)
                    }
                }
            }
        }
    
    func requestDogData(completion: @escaping ([DogModel]?, Error?) -> Void) {
        let dogUrl = "https://raw.githubusercontent.com/MixonUa/JSON-Facts/main/dogs.json"
        networkManager.requestData(url: dogUrl) { (data, error) in
            guard let data = data else { return }
            do {
                let answer = try JSONDecoder().decode([DogModel].self, from: data)
                DispatchQueue.main.async {
                    completion(answer, nil)
                    }
                } catch (let decodingError) {
                    DispatchQueue.main.async {
                        completion(nil, decodingError)
                    }
                }
            }
        }
}
