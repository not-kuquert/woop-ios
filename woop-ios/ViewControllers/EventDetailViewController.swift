//
//  EventDetailViewController.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/25/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit
import MapKit

class EventDetailViewController: UIViewController {
    
    var event: Event!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    class func newInstance(event: Event) -> EventDetailViewController {
        let controller = R.storyboard.main.eventDetailViewController()!
        controller.event = event
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = event.description
    }
}
