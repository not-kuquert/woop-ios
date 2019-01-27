//
//  Roundable.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/27/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

protocol Roundable {
    func setCornerRadius(cornerRadius: CGFloat)
}

extension Roundable where Self: UIView {
    func setCornerRadius(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius == -1 ? min(bounds.width, bounds.height) / 2 : cornerRadius
        layer.masksToBounds = true
    }
}
