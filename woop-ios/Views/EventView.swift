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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateView: DateView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var event: Event? {
        didSet {
            titleLabel.text = event?.title
            dateView.date = event?.date
            priceLabel.text = String(event?.price ?? 0) //TODO: Remove this fallback to zero
            
             //TODO: Move this gambi to the decoder
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
        
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowBlur
        self.layer.cornerRadius = cardRadius
        
        backgroundImageView.layer.cornerRadius = cardRadius
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
    }
}
