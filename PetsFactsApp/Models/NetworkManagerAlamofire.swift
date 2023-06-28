//
//  NetworkManagerAlamofire.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 25.06.2023.
//

import Foundation
import Alamofire

class NetworkManagerAlamofire {
    func requestData(url: String, completion: @escaping (Data?, Error?) -> Void) {
    AF.request(url).response { response in
        guard let data = response.data else {
            completion(nil, response.error)
            return
        }
        completion(data, nil)
        }
    }
}
