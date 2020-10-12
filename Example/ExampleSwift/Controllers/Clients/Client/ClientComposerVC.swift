//
//  ClientComposerVC.swift
//  ExampleSwift
//
//  Created by Brooma Service on 27.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import UIKit

class ClientComposerVC: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var clientIdLabel: UILabel!
    @IBOutlet weak var clientIdInput: UITextField!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var clientNameInput: UITextField!
    @IBOutlet weak var appMarkerLabel: UILabel!
    @IBOutlet weak var appMarkerInput: UITextField!
    @IBOutlet weak var signatureLabel: UILabel!
    @IBOutlet weak var signatureInput: UITextField!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataInput: UITextField!
    @IBOutlet var activityView: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clientIdInput.becomeFirstResponder()
    }
    
    //MARK: - Client Methods

    @IBAction func saveClient(_ sender: Any) {
        
        if let clientId = validateClientId(clientIdInput.text) {
            
            //Autocorrecting wrong quotes input
            var data = dataInput.text
            data = data?.replacingOccurrences(of: "“", with: "\"")
                .replacingOccurrences(of: "”", with: "\"")
                .replacingOccurrences(of: "„", with: "\"")
            
            let client = Client.init(id: clientId,
                                     name: clientNameInput.text,
                                     appMarker: appMarkerInput.text,
                                     signature: signatureInput.text,
                                     data: data)
            
            if let signature = client.signature, !signature.isEmpty {
                addClient(client)
            } else {
                loadSignature(for: client)
            }
        }
    }
    
    func validateClientId(_ clientIdIn: String?) -> String? {
        
        if let clientId = clientIdIn {
            
            if (hasClient(withId: clientId)) {
                clientIdLabel.textColor = UIColor.red
                clientIdLabel.text = NSLocalizedString("Client Id (Exist)", comment: "")
                return nil
            
            } else {
                clientIdLabel.textColor = UIColor.black
                clientIdLabel.text = NSLocalizedString("Client Id", comment: "")
                return clientId
            }
            
        } else {
            clientIdLabel.textColor = UIColor.red
            clientIdLabel.text = NSLocalizedString("Client Id (Required)", comment: "")
            return nil
        }
    }
    
    func addClient(_ client: Client) {
        Storage.instance.add(client: client)
        navigationController?.popViewController(animated: true)
    }
    
    func hasClient(withId id: String) -> Bool {
        
        let clients = Storage.instance.clients
        var foundPosition:Int = NSNotFound
        
        for (position, client) in clients.enumerated() {
            if client.id == id {
                foundPosition = position
                break
            }
        }
        
        return foundPosition != NSNotFound;
    }
    
    func loadSignature(for client: Client) {
        
        startAnimating()
        
        weak var weakSelf = self
        SignatureService.instance.serverURL = URL(string: "")
        SignatureService.instance.getSignature(for: client.id) { (signature, error) in
            
            DispatchQueue.main.async {
                weakSelf?.stopAnimating()
                
                if error == nil {
                    client.signature = signature
                    weakSelf?.addClient(client)
                    
                } else {
                    weakSelf?.presentSignatureLoadingFailedAlert(withError: error!, continueHandler: {
                        weakSelf?.addClient(client)
                    })
                }
            }
        }
    }

    //MARK: - UI Methods

    func presentSignatureLoadingFailedAlert(withError error: Error, continueHandler: @escaping ()-> Void) {
        
        let message = String.localizedStringWithFormat("Signature loading failed with error: %@", error.localizedDescription)
        
        let alert = UIAlertController.init(title: NSLocalizedString("Signature", comment: ""),
                                           message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("Continue", comment: ""),
                                           style: .default,
                                           handler: { (action) in
                                            continueHandler()}))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    func startAnimating() {
        
        let item = UIBarButtonItem.init(customView:self.activityView)
        self.navigationItem.rightBarButtonItem = item
        activityView.startAnimating()
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = false
    }

    func stopAnimating() {
        activityView.stopAnimating()
        self.navigationItem.rightBarButtonItem = saveButton
        self.view.isUserInteractionEnabled = true
    }

    //MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch (textField.tag) {
        case 0:
            clientNameInput.becomeFirstResponder()
            break
        case 1:
            appMarkerInput.becomeFirstResponder()
            break
        case 2:
            signatureInput.becomeFirstResponder()
            break
        case 3:
            signatureInput.resignFirstResponder()
            break
        default:
            signatureInput.resignFirstResponder()
        }
        return true
    }

}
