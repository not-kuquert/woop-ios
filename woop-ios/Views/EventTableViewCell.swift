//
//  EventTableViewCell.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/25/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateView: DateView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentContainerView.layer.cornerRadius = 8
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundImageView.alpha = highlighted ? 0.4 : 1
        titleLabel.textColor = highlighted ? .black : .white
    }
    
    //TODO: Add contrasted text color depending on image avrage color
    func render(event: Event) {
        titleLabel.text = event.title
        dateView.date = event.date
        priceLabel.text = String(event.price)
        let a = event.image.replacingOccurrences(of: "http://", with: "https://")
        
        backgroundImageView?.kf.setImage(with: URL(string: a),
                                         placeholder: UIImage(named: "placeholder"))
        shadowView.cellShadow()
    }
}
