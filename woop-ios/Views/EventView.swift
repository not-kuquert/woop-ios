//
//  EventView.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/26/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

class EventView: UIView, NibLoadable {
    private var shadowBlur: CGFloat = 8
    private var shadowOpacity: Float = 0.7
    private var shadowColor: UIColor = UIColor.red
    private var backgroundImage: UIImage?
    private var cardRadius: CGFloat = 20

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet var dateView: DateView!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var peopleView: PeopleView!

    var event: Event? {
        didSet {
            peopleView.people = event?.people
            titleLabel.text = event?.title
            dateView.date = event?.date
            
            if let price = event?.price, price > 0 {
                priceLabel.text = R.string.localizable.price(String(format: "%.2f", price))
            }

            // TODO: Move this gambi to the decoder
            if let a = event?.image.replacingOccurrences(of: "http://", with: "https://") {
                backgroundImageView?.kf.setImage(with: URL(string: a),
                                                 placeholder: UIImage(named: "placeholder"))
            }
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

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = shadowBlur
        layer.cornerRadius = cardRadius

        backgroundImageView.layer.cornerRadius = cardRadius
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
        
        priceView.layer.cornerRadius = priceView.frame.size.height/2
    }    
}
