//
//  EventDetailViewController.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/25/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet var eventView: EventView!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var checkinButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!

    private var event: Event!

    class func newInstance(event: Event) -> EventDetailViewController {
        let controller = R.storyboard.main.eventDetailViewController()!
        controller.event = event
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWith(event: event)
        checkinButton.addTarget(self, action: #selector(showCheckinAlert), for: .touchUpInside)
    }

    private func configureWith(event: Event) {
        descriptionLabel.text = event.description
        eventView.event = event
        populatAddessLabel(event: event)
    }

    private func populatAddessLabel(event: Event) {
        let location = CLLocation(latitude: event.latitude, longitude: event.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let placemark = placemarks?.first,
                let address = placemark.name,
                let city = placemark.locality,
                let neighborhood = placemark.subLocality else { return }

            self?.addressLabel.text = R.string.localizable.address(address, neighborhood, city)
        }
    }

    private func handleCheckin(name: String, email: String) {
        let checkin = Checkin(eventId: event.id, name: name, email: email)

        EventsFacade.shared.checkIn(checkin: checkin, completion: { [weak self] _, error in
            guard error == nil else {
                self?.showInfoAlert(title: R.string.localizable.checkin_failure_title())
                self?.checkinButton.isEnabled = true
                return
            }

            self?.showInfoAlert(title: R.string.localizable.checkin_success_title())
            self?.checkinButton.isEnabled = false
        })
    }

    @objc private func showCheckinAlert() {
        let alert = UIAlertController(title: R.string.localizable.checkin_alert_title(),
                                      message: R.string.localizable.checkin_alert_message(),
                                      preferredStyle: .alert)
        addActions(on: alert)
        present(alert, animated: true)
    }

    private func showInvalidCheckinAlert() {
        let alert = UIAlertController(title: R.string.localizable.checkin_invalid_title(),
                                      message: R.string.localizable.checkin_invalid_message(),
                                      preferredStyle: .alert)
        addActions(on: alert)
        present(alert, animated: true)
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

        alert.addAction(UIAlertAction(title: R.string.localizable.alert_checkin_button(), style: .default, handler: { [weak self, weak alert] _ in

            func isValid(name: String, email: String) -> Bool {
                return (email.count > 0 && email.contains("@") && name.count > 0)
            }

            guard let name = alert?.textFields?.get(at: 0)?.text,
                let email = alert?.textFields?.get(at: 1)?.text,
                isValid(name: name, email: email) else {
                self?.showInvalidCheckinAlert()
                return
            }

            self?.handleCheckin(name: name, email: email)
        }))
    }
}
