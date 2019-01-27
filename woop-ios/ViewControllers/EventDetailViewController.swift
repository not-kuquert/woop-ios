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
        
        checkinButton.addTarget(self, action: #selector(showCheckinAlert), for: .touchUpInside)
        checkinButton.layer.cornerRadius = 10
    }
    
    private func populatAddessLabel(event: Event) {
        let location = CLLocation(latitude: event.latitude, longitude: event.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.first,
                let address = placemark.name,
                let city = placemark.locality,
                let neighborhood = placemark.subLocality else { return }
            
            self?.addressLabel.text = R.string.localizable.address(address, neighborhood, city)
        }
    }
    
    @objc private func showCheckinAlert() {
        let alert = UIAlertController(title: R.string.localizable.checkin_alert_title(),
                                      message: R.string.localizable.checkin_alert_message(),
                                      preferredStyle: .alert)
        addActions(on: alert)
        self.present(alert, animated: true)
    }
    
    private func showInvalidCheckinAlert() {
        let alert = UIAlertController(title: R.string.localizable.checkin_invalid_title(),
                                      message: R.string.localizable.checkin_invalid_message(),
                                      preferredStyle: .alert)
        addActions(on: alert)
        self.present(alert, animated: true)
    }
    
    private func showInfoAlert(title: String) {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alert_default_button(),
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    private func addActions(on alert: UIAlertController) {
        alert.addAction(UIAlertAction(title: R.string.localizable.alert_cancel_button(),
                                      style: .default,
                                      handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = R.string.localizable.input_name_placeholder()
            textField.autocorrectionType = .no
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = R.string.localizable.input_email_placeholder()
            textField.keyboardType = .emailAddress
        })
        
        // TODO: Deal with possible memory leaks here due to selfs
        alert.addAction(UIAlertAction(title: R.string.localizable.alert_checkin_button(), style: .default, handler: { action in
            
            func isValid(name: String, email: String) -> Bool {
                return (email.count > 0 && email.contains("@") && name.count > 0)
            }
            
            guard let name = alert.textFields?.get(at: 0)?.text,
                let email = alert.textFields?.get(at: 1)?.text,
                isValid(name: name, email: email) else {
                self.showInvalidCheckinAlert()
                return
            }
            
            EventsFacade.checkIn(checkin: Checkin(eventId: self.event.id, name: name, email: email),
                                 completion: { (response, error) in
                                    switch response?.code {
                                    case .some("200"):
                                        self.showInfoAlert(title: R.string.localizable.checkin_success_title())
                                        self.checkinButton.isEnabled = false
                                    default:
                                        self.showInfoAlert(title: R.string.localizable.checkin_failure_title())
                                        self.checkinButton.isEnabled = true
                                    }
            })
        }))
        
    }
}
