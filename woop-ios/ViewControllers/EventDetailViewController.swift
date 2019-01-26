//
//  EventDetailViewController.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/25/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class EventDetailViewController: UIViewController {
    
    var event: Event!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var eventView: EventView!
    
    class func newInstance(event: Event) -> EventDetailViewController {
        let controller = R.storyboard.main.eventDetailViewController()!
        controller.event = event
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = event.description
        eventView.event = event
        populatAddessLabel(event: event)
    }
    
    private func populatAddessLabel(event: Event) {
        //TODO: get locatio from address when we have it
        let location = CLLocation(latitude: -30.0392981, longitude: -51.2146267)
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.first else { return }
            
            if let address = placemark.name,
                let city = placemark.locality,
                let neighborhood = placemark.subLocality {
                self?.addressLabel.text = "\(address), \(neighborhood) - \(city)"
            }
        }
        
    }
}
