//
//  DateView.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/26/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

@IBDesignable final class DateView: UIView, NibLoadable {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!

    private var dayFormatter = DateFormatter(dateFormat: "d")
    private var monthFormatter = DateFormatter(dateFormat: "MMM")
    private var yearFormatter = DateFormatter(dateFormat: "yyyy")

    var date: Date? {
        didSet {
            guard let date = date else { return }
            dayLabel.text = dayFormatter.string(from: date)
            monthLabel.text = monthFormatter.string(from: date).uppercased()
            yearLabel.text = yearFormatter.string(from: date)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
