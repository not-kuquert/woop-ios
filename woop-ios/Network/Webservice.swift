//
//  Webservice.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct Webservice: Service {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: resource.urlRequest) { data, _, _ in
            DispatchQueue.main.async {
                completion(data.flatMap(resource.parse))
            }
            }.resume()
    }
}
