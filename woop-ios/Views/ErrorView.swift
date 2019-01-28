//
//  ErrorView.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/27/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

protocol ErrorViewDelegate {
    func errorViewDidRetry()
    func errorViewTitle() -> String
    func errorViewMessage() -> String
}

final class ErrorView: UIView, NibLoadable {
    @IBOutlet var contentView: UIView!

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!

    var delegate: ErrorViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }

    func show() {
        titleLabel.text = delegate?.errorViewTitle()
        messageLabel.text = delegate?.errorViewMessage()
        contentView.isHidden = false
    }

    func hide() {
        contentView.isHidden = true
    }

    @IBAction func retryButtonTouched() {
        delegate?.errorViewDidRetry()
    }
}
