//
//  Webservice.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct Webservice: Service {
    func load<T>(resource: Resource<T>, completion: @escaping (T?, Error?) -> Void) {
        URLSession.shared.dataTask(with: resource.urlRequest) { data, _, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, error)
                    return
                }

                let result = data.flatMap(resource.parse)
                completion(result?.0, result?.1)
            }
        }.resume()
    }
}
