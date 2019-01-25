//
//  Mockservice.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation


struct Mockservice: Service {
    func get<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        var data: Data?
        switch T.self {
        case is [Event].Type:
            data = dataForFile(name: "events")
            
        case is Event.Type:
            data = dataForFile(name: "event1")
            
        default:
            assertionFailure("No mock data available")
        }
        
        completion(data != nil ? resource.parse(data!) : nil)
    }
    
    private func dataForFile(name: String) -> Data? {
        let path = Bundle.main.path(forResource: name, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return data
    }
}
