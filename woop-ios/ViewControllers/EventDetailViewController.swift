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
    @IBOutlet weak var checkinButton: UIButton!
    
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
        
        checkinButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
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
    
    @objc private func showAlert() {
        //TODO: Extarct string to strings file
        let alert = UIAlertController(title: "Precisamos de algumas informanções",
                                      message: "Para manter você informado sobre o evento e saber quem você é, precisamos de algumas informações",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Nome"
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "E-mail"
            textField.keyboardType = .emailAddress
        })
        
        alert.addAction(UIAlertAction(title: "Check-in", style: .default, handler: { action in
            if let name = alert.textFields?.get(at: 0)?.text,
                let email = alert.textFields?.get(at: 1)?.text {
                //TODO: validate info, if not valid show invalid info alert with prefilled information
                //self.present(alert, animated: true)
                print("Your name: \(name)")
                print("Your email: \(email)")
            }
            
        }))
        
        self.present(alert, animated: true)
    }
}
