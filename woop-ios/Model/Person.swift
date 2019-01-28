//
//  Person.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/23/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

struct Person: Codable {
    var id: String
    var eventId: String
    var name: String
    var picture: String

    var pictureUrl: URL {
        return URL(string: picture.replacingOccurrences(of: "http://", with: "https://"))!
    }
}
