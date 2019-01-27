//
//  EventsFacade.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct EventsFacade {
    //TODO: Change this based on the schema
    private static let loadLocally = false
    
    private static func baseUrlWith(path: String) -> URL {
        //TODO: Remove forced unwrap, add this to envVar
        return URL(string: "https://5b840ba5db24a100142dcd8c.mockapi.io/api/")!.appendingPathComponent(path)
    }
    
    private static let service: Service = EventsFacade.loadLocally ? Mockservice() : Webservice()

    static func events(completion: @escaping ([Event]?, Error?) -> Void) {
        let resource = Resource<[Event]>(get: EventsFacade.baseUrlWith(path: "events"))
        EventsFacade.service.load(resource: resource, completion: completion)
    }

    static func event(id: String, completion: @escaping (Event?, Error?) -> Void) {
        let resource = Resource<Event>(get: EventsFacade.baseUrlWith(path: "events/\(id)"))
        EventsFacade.service.load(resource: resource, completion: completion)
    }

    static func checkIn(checkin: Checkin, completion: @escaping (EmptyResponse?, Error?) -> Void) {
        let resource = Resource<EmptyResponse>(url: EventsFacade.baseUrlWith(path: "checkin"),
                                               method: .post(checkin))
        EventsFacade.service.load(resource: resource, completion: completion)
    }
}
