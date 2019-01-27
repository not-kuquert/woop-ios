//
//  ViewController.swift
//  woop-ios
//
//  Created by Marcus Vinicius Kuquert on 1/23/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import UIKit
import Kingfisher

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func removeEmptyMessage() {
        self.backgroundView = nil
    }
}

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
        EventsFacade.events() { [weak self] (events, error) in
            guard error == nil else {
                //TODO: Decide how we should present errors for the user
                print(error)
                return
            }
            
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
        if events.count == 0 {
            tableView.setEmptyMessage("Nenhum evento para mostrar")
        } else {
            tableView.removeEmptyMessage()
        }
        
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
