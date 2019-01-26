//
//  DateView.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/26/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

class DateView: UIView, NibLoadable {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
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
}