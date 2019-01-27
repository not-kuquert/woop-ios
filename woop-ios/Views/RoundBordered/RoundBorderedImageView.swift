//
//  RoundBorderedImageView.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/27/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

@IBDesignable
final class RoundBorderedImageView: UIImageView, Roundable {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var cornerRadius: CGFloat = -1 {
        didSet { setNeedsLayout() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        setCornerRadius(cornerRadius: cornerRadius)
    }
}
