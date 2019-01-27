//
//  PeopleView.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/27/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit

class PeopleView: UIView, NibLoadable {
    @IBOutlet var peoplePictures: [UIImageView]!
    @IBOutlet var extraPeopleView: UIView!
    @IBOutlet var extraPeopleLabel: UILabel!

    var people: [Person]? {
        didSet {
            configure()
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

    private func configure() {
        let extraCount = calculateExtra(people: people)
        extraPeopleView.isHidden = (extraCount == 0)
        extraPeopleLabel.text = "+\(extraCount)"

        for (index, imageView) in peoplePictures.enumerated() {
            if let image = people?.get(at: index)?.picture.replacingOccurrences(of: "http://",
                                                                                with: "https://") {
                imageView.kf.setImage(with: URL(string: image),
                                      placeholder: UIImage(named: "naruto"))
            }
        }
    }

    private func calculateExtra(people: [Person]?) -> Int {
        guard let people = people else { return 0 }
        return max((people.count - peoplePictures.count), 0)
    }

    override func draw(_: CGRect) {
        for imageView in peoplePictures {
            configureBorder(in: imageView)
        }
        
        configureBorder(in: extraPeopleView)
    }
    
    private func configureBorder(in view: UIView) {
        view.layer.cornerRadius = view.frame.size.height / 2
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
    }
}
