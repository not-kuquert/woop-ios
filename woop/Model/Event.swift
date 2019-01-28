//
//  Event.swift
//  woop
//
//  Created by Marcus Vinicius Kuquert on 1/23/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct Event: Codable {
    var id: String
    var title: String
    var price: Double
    var image: String
    var latitude: Double
    var longitude: Double
    var description: String
    var date: Date
    var people: [Person]
    var cupons: [Cupon]

    var imageUrl: URL {
        return URL(string: image.replacingOccurrences(of: "http://", with: "https://"))!
    }
}

extension Event {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Double.self, forKey: .price)
        image = try container.decode(String.self, forKey: .image)
        description = try container.decode(String.self, forKey: .description)
        date = try container.decode(Date.self, forKey: .date)
        people = try container.decode([Person].self, forKey: .people)
        cupons = try container.decode([Cupon].self, forKey: .cupons)

        if let stringValue = try? container.decode(String.self, forKey: .latitude),
            let doubleValue = Double(stringValue) {
            latitude = doubleValue
        } else {
            latitude = try container.decode(Double.self, forKey: .latitude)
        }

        if let stringValue = try? container.decode(String.self, forKey: .longitude),
            let doubleValue = Double(stringValue) {
            longitude = doubleValue
        } else {
            longitude = try container.decode(Double.self, forKey: .longitude)
        }
    }
}
