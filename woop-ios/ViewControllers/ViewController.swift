//
//  ViewController.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/23/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import Kingfisher
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    private var events: [Event] = []
    private var errorView = ErrorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        errorView.delegate = self
        tableView.backgroundView = errorView
        loadEvents()
    }

    private func loadEvents() {
        EventsFacade.shared.events { [weak self] events, error in
            guard error == nil, events != nil else {
                self?.errorView.show()
                return
            }

            self?.events = events!
            self?.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.eventCell,
                                                 for: indexPath)!
        cell.render(event: events[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 420.0
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailVC = EventDetailViewController.newInstance(event: events[indexPath.row])
        navigationController?.pushViewController(eventDetailVC, animated: true)
    }
}

extension ViewController: ErrorViewDelegate {
    func errorViewDidRetry() {
        errorView.hide()
        loadEvents()
    }

    func errorViewTitle() -> String {
        return R.string.localizable.error_title()
    }

    func errorViewMessage() -> String {
        return R.string.localizable.error_message()
    }
}
