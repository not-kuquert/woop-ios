//
//  HttpMethod.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

enum HttpMethod {
    case get
    case post(Data)
}

extension HttpMethod { //TODO: Maybe remove the extensions and add directelly to the struct
    var method: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}
