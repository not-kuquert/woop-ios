//
//  ApiRouter.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/25/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

enum ApiRouter {
    case events
    case event(id: String)
    case checkin(data: Checkin)
    
    var method: HttpMethod {
        switch self {
        case .events,
             .event:
            return .get
        case .checkin:
            return .get
//            return .post(data) TODO: Change this to post using data
        }
    }
    
    private static func baseUrlWith(path: String) -> URL {
        return URL(string: "https://5b840ba5db24a100142dcd8c.mockapi.io/api/")!.appendingPathComponent(path) //TODO: Remove forced unwrap, add this to envVar
    }
    
    var url: URL {
        switch self {
        case .event(let id):
            return ApiRouter.baseUrlWith(path: "events/\(id)")
        case .events:
            return ApiRouter.baseUrlWith(path: "events")
        case .checkin:
            return ApiRouter.baseUrlWith(path: "checkin")
        }
    }
}
