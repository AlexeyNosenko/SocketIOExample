//
//  OnlineUsersTableViewController.swift
//  
//
//  Created by Алексей on 21.07.2018.
//

import UIKit

class OnlineUsersTableViewController: UITableViewController {

    // MARK: - Properties
    var chat: Chat? {
        didSet {
            self.navigationController?.title = chat?.name
            tableView.reloadData()
        }
    }
    
    static let cellIdentifier = "onlineUsersCell"

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat?.users?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = chat?.users?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: OnlineUsersTableViewController.cellIdentifier,
                                                 for: indexPath)
        cell.textLabel?.text = user.nickname
        cell.detailTextLabel?.text = user.online
        cell.detailTextLabel?.textColor = user.isOnline ? .green : .red

        return cell
    }
}
