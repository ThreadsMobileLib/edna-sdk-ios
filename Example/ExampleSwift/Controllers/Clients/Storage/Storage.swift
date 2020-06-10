//
//  Storage.swift
//  ExampleSwift
//
//  Created by Brooma Service on 29.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import UIKit

class Storage: NSObject {

    static let instance = Storage()
    
    var clients: Array<Client> {
        didSet {
            clientsObserver?(clients)
        }
    }

    private var clientsObserver: ((Array<Client>) -> ())?
    
    override private init() {
        self.clients = Storage.loadClients() ?? Array()
        super.init()
    }
    
    class func loadClients() -> Array<Client>? {
        
        NSKeyedUnarchiver.setClass(Client.self, forClassName: "Client")
        
        do {
            let data = try Data.init(contentsOf: dataFileURL())
            
            if let encodedClients = NSKeyedUnarchiver.unarchiveObject(with: data) as? Data {
                let clientsArray = try PropertyListDecoder().decode(Array<Client>.self, from: encodedClients)
                return clientsArray
            
            } else if let encodedClients = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Client] {
                //Check if old NSCoding archive and rewrite to new
                saveClients(encodedClients)
                return encodedClients
                
            } else {
                print ("Read Failed")
                return nil
            }
        } catch {
            print ("Read Failed: \(error)")
            return nil
        }
    }

    class func saveClients(_ clients: Array<Client>) {
        
        do {
            let encodedClients = try PropertyListEncoder().encode(clients)
            let data = NSKeyedArchiver.archivedData(withRootObject: encodedClients)
            try data.write(to: dataFileURL(), options: .atomicWrite)
        } catch {
            print ("Write Failed: \(error)")
        }
    }

    class func dataFileURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent("Clients.plist")
    }

    public func add(client: Client) {
        clients.append(client)
        Storage.saveClients(clients)
        clientsObserver?(clients)
    }

    public func remove(client: Client) {
        
        if let indexToRemove = clients.firstIndex(of: client) {
            clients.remove(at: indexToRemove)
            Storage.saveClients(clients)
            clientsObserver?(clients)
        }
    }
    
    public func setClientsObserver(observer: ((Array<Client>) -> ())?) {
        self.clientsObserver = observer
        self.clientsObserver?(clients)
    }
}
