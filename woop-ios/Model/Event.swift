//
//  Event.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/23/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct Event: Codable {
    var cupons: [Cupon]
    var date: Date // "date": 1534784400000
    var description: String
    var id: String
    var image: String //can be a Url too
    var latitude: String
    var longitude: String
    var people: [Person]
    var price: Double
    var title: String
}
