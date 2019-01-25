//
//  Webservice.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct Webservice: Service {
    func get<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        print(resource.self)
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data != nil ? resource.parse(data!) : nil)
            }
            }.resume()
    }
}
