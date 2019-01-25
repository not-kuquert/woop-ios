//
//  EventsFacade.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct EventsFacade {
    static let shared = EventsFacade()
    private static let loadLocally = false //TODO: Change this based on the schema
    
    private let service: Service = EventsFacade.loadLocally ? Mockservice() : Webservice()
    
    func events(completion: @escaping ([Event]?) -> ()) {
        let resource = Resource<[Event]>(url: ApiRouter.events.url,
                                         method: ApiRouter.events.method)
        
        service.get(resource: resource, completion: completion)
    }
}
