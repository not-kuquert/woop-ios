//
//  ViewController.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/23/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadEvents()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func loadEvents() {
        EventsFacade.events() { [weak self] events in
            self?.events = events ?? [] // TODO: Should handle error here
            self?.tableView.reloadData()
        }
    }
}


extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.eventCell,
                                                 for: indexPath)!
        cell.render(event: events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320.0
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(EventDetailViewController.newInstance(event: events[indexPath.row]),
                                                 animated: true)
    }
}

