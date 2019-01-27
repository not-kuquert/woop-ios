//
//  Resource.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct Resource<A> {
    var urlRequest: URLRequest
    let parse: (Data) -> (A?, Error?)
}

extension Resource where A: Decodable {
    init(get url: URL) {
        urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        //TODO: get rid of code duplication
        self.parse = { data in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .millisecondsSince1970
                
                return (try decoder.decode(A.self, from: data), nil)
            } catch let error {
                return (nil, error)
            }
        }
    }

    init<Body: Encodable>(url: URL, method: HttpMethod<Body> = .get) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        switch method {
        case .get: ()
        case .post(let body):
            self.urlRequest.httpBody = try! JSONEncoder().encode(body)
        }
        
        self.parse = { data in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .millisecondsSince1970
                
                return (try decoder.decode(A.self, from: data), nil)
            } catch let error {
                return (nil, error)
            }
        }
    }
}
