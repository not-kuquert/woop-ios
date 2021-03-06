//
//  EventView.swift
//  woop
//
//  Created by Marcus Vinicius Kuquert on 1/26/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

@IBDesignable
final class EventView: UIView, NibLoadable {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateView: DateView!
    @IBOutlet var peopleView: PeopleView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!

    var event: Event? {
        didSet {
            peopleView.people = event?.people
            titleLabel.text = event?.title
            dateView.date = event?.date

            backgroundImageView?.kf.setImage(with: event?.imageUrl,
                                             placeholder: R.image.placeholder())

            if let price = event?.price, price > 0 {
                let formattedPrice = String(format: "%.2f",
                                            locale: Locale(identifier: "pt_BR"),
                                            price)

                priceLabel.text = R.string.localizable.price(formattedPrice)
            } else {
                priceLabel.text = R.string.localizable.price_free()
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

        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
    }
}
