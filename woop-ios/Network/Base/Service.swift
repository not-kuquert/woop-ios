//
//  Service.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/24/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Foundation

protocol Service {
    func get<T>(resource: Resource<T>, completion: @escaping (T?) -> ())
//    func post<>()
}
