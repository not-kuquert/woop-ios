//
//  Resource.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let method: HttpMethod
    let parse: (Data) -> T?
}

extension Resource where T: Decodable {
    init(url: URL, method: HttpMethod = .get) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        
        self.url = url
        self.method  = method
        self.parse = { data in
            //TODO handle decode errors here.
            do {
                return try decoder.decode(T.self, from: data)
            } catch let error {
                print(error)
                return nil
            }
            
        }
    }
}
