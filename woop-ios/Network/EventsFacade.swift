//
//  EventsFacade.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

enum Enviroment {
    case local, development, production
}

struct EventsFacade {
    private let service: Service

    static let shared = EventsFacade(service: Webservice())
    static let sharedLocal = EventsFacade(service: Mockservice())

    private static func baseUrlWith(path: String) -> URL {
        return URL(string: "https://5b840ba5db24a100142dcd8c.mockapi.io/api/")!.appendingPathComponent(path)
    }

    func events(completion: @escaping ([Event]?, Error?) -> Void) {
        let resource = Resource<[Event]>(get: EventsFacade.baseUrlWith(path: "events"))
        service.load(resource: resource, completion: completion)
    }

    func event(id: String, completion: @escaping (Event?, Error?) -> Void) {
        let resource = Resource<Event>(get: EventsFacade.baseUrlWith(path: "events/\(id)"))
        service.load(resource: resource, completion: completion)
    }

    func checkIn(checkin: Checkin, completion: @escaping (EmptyResponse?, Error?) -> Void) {
        let resource = Resource<EmptyResponse>(url: EventsFacade.baseUrlWith(path: "checkin"),
                                               method: .post(checkin))
        service.load(resource: resource, completion: completion)
    }
}
