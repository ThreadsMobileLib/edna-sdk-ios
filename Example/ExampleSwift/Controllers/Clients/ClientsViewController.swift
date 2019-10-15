//
//  ClientsViewController.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads

class ClientsViewController: UIViewController, ClientsTableViewDataSourceDelegate {
    
    @IBOutlet var clientsTableViewDataSource: ClientsTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func isClientSet() -> Bool {
        return Threads.threads().isClientSet
    }
    
    func isCurrentClient(_ client: Client) -> Bool {
        return Threads.threads().clientId == client.id
    }
    
    func activate(_ client: Client) {
        Threads.threads().setClientWithId(
            client.id,
            name: client.name,
            appMarker: client.name,
            signature: client.signature
        )
    }
    
    func delete(_ client: Client) {
        if isCurrentClient(client) {
            Threads.threads().logout()
        } else {
            Threads.threads().logout(withClientId: client.id)
        }
    }
  
}
