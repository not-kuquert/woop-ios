//
//  Mockservice.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

enum MyLittleError: Error {
    case noData
}

struct Mockservice: Service {
    func load<T>(resource: Resource<T>, completion: @escaping (T?, Error?) -> Void) {
        var data: Data?
        switch T.self {
        case is [Event].Type:
            data = dataForFile(name: "events")

        case is Event.Type:
            data = dataForFile(name: "event1")

        default:
            assertionFailure("No mock data available")
        }
        if let data = data {
            let result = resource.parse(data)
            completion(result.0, result.1)
        } else {
            completion(nil, MyLittleError.noData)
        }
    }

    private func dataForFile(name: String) -> Data? {
        let path = Bundle.main.path(forResource: name, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return data
    }
}
