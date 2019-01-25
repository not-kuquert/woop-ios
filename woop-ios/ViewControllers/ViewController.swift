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
    
    @IBOutlet weak var label: UILabel!
    
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
        EventsFacade.shared.events { [weak self] (events) in
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
        print("Should show event detail view \(indexPath.row)")
        navigationController?.pushViewController(EventDetailViewController.newInstance(event: events[indexPath.row]),
                                                 animated: true)
    }
}

extension UIView {
    private func baseShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.masksToBounds = false
    }
    
    func cellShadow(cornerRadius: CGFloat = 8) {
        baseShadow()
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 3.0
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: cornerRadius).cgPath
    }
    
    func headerShadow() {
        baseShadow()
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
}
