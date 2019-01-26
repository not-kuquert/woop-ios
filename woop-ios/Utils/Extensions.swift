//
//  Extensions.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/26/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

extension UIView {
    func edges(to view: UIView,
               top: CGFloat=0,
               left: CGFloat=0,
               bottom: CGFloat=0,
               right: CGFloat=0) {
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
            ])
    }
    
    private func baseShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.masksToBounds = false
    }
    
    func cellShadow(cornerRadius: CGFloat = 8) {
        baseShadow()
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 3.0
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: cornerRadius).cgPath
    }
    
    func headerShadow() {
        baseShadow()
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
}


extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}


extension Collection {
    func get(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
