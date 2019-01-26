//
//  EventTableViewCell.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/25/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    static let highlightFactor: CGFloat = 0.96
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        let animationBlock: () -> Void
        
        if isHighlighted {
            animationBlock = { [weak self] in
                self?.transform = .init(scaleX: EventTableViewCell.highlightFactor,
                                        y: EventTableViewCell.highlightFactor)
                }
        } else {
            animationBlock = { [weak self] in
                self?.transform = .identity
            }
        }
        
        UIView.animate(withDuration: 0.5,
        delay: 0,
        usingSpringWithDamping: 1,
        initialSpringVelocity: 0,
        options: [],
        animations: animationBlock,
        completion: completion)
    }
}
