//
//  ClientsViewController.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads
import Foundation

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
        let clientInfo = THRClientInfo(clientId: client.id)
        clientInfo.name = client.name
        clientInfo.data = client.data
        clientInfo.appMarker = client.appMarker
        clientInfo.signature = client.signature
        clientInfo.authToken = client.authToken
        clientInfo.authSchema = client.authSchema
        
        Threads.threads().setClientInfo(clientInfo)
    }
    
    func registerUserIfNeed(clientInfo: THRClientInfo){
        let key = clientKey(clientId: clientInfo.clientId)
        let alreadyRegisterClient = (UserDefaults.standard.value(forKey: key) as? Bool) ?? false
        if !alreadyRegisterClient{
            let messageWithText = "New client: \(clientInfo.clientId)"
            
            Threads.threads().registerUser(with: clientInfo, messageWithText: messageWithText)
        }
        UserDefaults.standard.setValue(true, forKey: key)
    }
    
    func clientKey(clientId: String) -> String{
        let clientHashValue = Hashes.md5(clientId)
        return "client_\(clientHashValue)_already_register"
    }
    
    func didDelete(_ client: Client) {
        if isActiveClient(client) {
            Threads.threads().logout()
        } else {
            Threads.threads().logout(withClientId: client.id)
        }
    }
  
}

import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class Hashes{
    static func md5(_ string: String) -> String{
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }

        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}
