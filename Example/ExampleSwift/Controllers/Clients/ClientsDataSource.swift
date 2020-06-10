//
//  ClientsDataSource.swift
//  ExampleSwift
//
//  Created by Brooma Service on 27.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import UIKit

protocol ClientsDataSourceDelegate {

    func isClientSet() -> Bool
    
    func isActiveClient(_ client: Client) -> Bool
    
    func activate(_ client: Client)
    
    func didDelete(_ client: Client)
}

class ClientsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: ClientsDataSourceDelegate!
    
    var clients: Array<Client>!
    
    override init() {
        super.init()
        self.clients = Storage.instance.clients
    }
    
    func configureClientsObserver() {
        
        weak var weakSelf = self
        Storage.instance.setClientsObserver { (clients) in
            
            weakSelf?.clients = clients
            let activated = weakSelf?.activateFirstAvailableClientIfNeeded() ?? false
            if (!activated) {
                weakSelf?.tableView.reloadData()
            }
        }
    }

    public func reactivateLastClient() {
        
        for (position, client) in clients.enumerated() {
            if (delegate.isActiveClient(client)) {
                delegate.activate(client)
                tableView.reloadRows(at: [IndexPath.init(row: position, section: 0)], with: .automatic)
            }
        }
    }

    func activateFirstAvailableClientIfNeeded() -> Bool {
        
        if (clients.isEmpty || delegate.isClientSet()) {
            return false
        
        } else {
            let client = clients.first!
            delegate.activate(client)
            tableView.reloadData()
            return true;
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (clients.count > 0) {
            return self.clients.count;
        } else {
            return 1;
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (clients.count > 0) {
            let client = clients[indexPath.row];
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ClientCell.resuseIdentifier(),
                for: indexPath)
            
            if let clientCell = cell as? ClientCell {
                clientCell.configure(for: client)
                clientCell.accessoryType = delegate.isActiveClient(client) ? .checkmark : .none
            }
            
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "NoClients", for: indexPath)
        }
    }

    func isClientIndexPath(_ indexPath: IndexPath) -> Bool {
        return tableView.cellForRow(at: indexPath) is ClientCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let client = clients[indexPath.row];
        delegate.didDelete(client)
        Storage.instance.remove(client: client)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (!isClientIndexPath(indexPath)) {
            return
        }
        
        let client = clients[indexPath.row];
        if (!delegate.isActiveClient(client)) {
            delegate.activate(client)
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return Configuration.summary()
    }
}
