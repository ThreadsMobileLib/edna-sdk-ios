//
//  ClientsViewController.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads

class ClientsViewController: UIViewController, ClientsDataSourceDelegate {
    
    @IBOutlet var clientsDataSource: ClientsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clientsDataSource.delegate = self
        clientsDataSource.configureClientsObserver()
        clientsDataSource.reactivateLastClient()
    }
    
    func isClientSet() -> Bool {
        return Threads.threads().isClientSet
    }
    
    func isActiveClient(_ client: Client) -> Bool {
        return Threads.threads().clientId == client.id
    }
    
    func activate(_ client: Client) {
        Threads.threads().setClientWithId(
            client.id,
            name: client.name,
            data: "{\"param1\": \"value1\"}",
            appMarker: client.appMarker,
            signature: client.signature
        )
    }
    
    func didDelete(_ client: Client) {
        if isActiveClient(client) {
            Threads.threads().logout()
        } else {
            Threads.threads().logout(withClientId: client.id)
        }
    }
  
}
