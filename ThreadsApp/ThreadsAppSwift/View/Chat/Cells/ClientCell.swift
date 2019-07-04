//
//  ClientCell.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 17/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import UIKit

protocol ClientCellDelegate : class {
    func logout(client : Client)
}

class ClientCell : UICollectionViewCell {
    
    @IBOutlet weak var clientId :  UILabel!
    @IBOutlet weak var clientName :  UILabel!
    @IBOutlet weak var appMarker :  UILabel!
    @IBOutlet weak var clientIdSignature : UILabel!
    @IBOutlet weak var logoutButton : UIButton!
    
    var client : Client!
    weak var delegate : ClientCellDelegate?
    
    class func getReuseIdentifier() -> String {
        return String(describing: self)
    }
    
    func setClient(_ client : Client) {
        self.client = client
        self.clientId.text = client.clientId;
        self.clientName.text = client.name;
        self.appMarker.text = client.appMarker;
        self.clientIdSignature.text = client.clientIdSignature;
    }
    
    func getClient() -> Client {
        return self.client!;
    }
    
    @IBAction func logout(_ sender : Any) {
        self.delegate?.logout(client: self.client)
    }
}
