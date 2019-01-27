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
    let parse: (Data) -> A?
}

extension Resource where A: Decodable {
    init(get url: URL) {
        urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        self.parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
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
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
}
