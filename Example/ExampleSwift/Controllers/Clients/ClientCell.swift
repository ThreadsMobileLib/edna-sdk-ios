//
//  ClientCell.swift
//  ExampleSwift
//
//  Created by Brooma Service on 27.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import UIKit

class ClientCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signatureLabel: UILabel!
    
    public class func resuseIdentifier() -> String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func configure(for client: Client) {
        idLabel.text = client.id;
        nameLabel.text = getClientName(for: client)
        signatureLabel.text = getClientSignature(for: client)
    }

    func getClientName(for client: Client) -> String {
        
        if let name = client.name, !name.isEmpty {
            return name
        } else {
            return NSLocalizedString("No Name", comment: "")
        }
    }

    func getClientSignature(for client: Client) -> String{
        
        if let signature = client.signature, !signature.isEmpty {
            return signature
        } else {
            return NSLocalizedString("Signature is missing", comment:"")
        }
    }

}
