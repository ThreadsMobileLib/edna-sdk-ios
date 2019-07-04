//
//  TextCell.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 16/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import UIKit

protocol TextCellDelegate: class {
    func textChanged(_ text: String?, inCell: TextCell)
}

class TextCell : UITableViewCell {
    
    weak var delegate : TextCellDelegate?
    
    var type: CellType!
    
    @IBOutlet weak var textField : UITextField!
    
    //MARK: - Initialize
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    //MARK: - Configuring
    
    func construct() {
        self.textField.placeholder = self.type.rawValue
    }
    
    func setText(_ text: String) {
        self.textField.text = text
        self.textFieldChanged(self.textField!)
    }
    
    func getText() -> String? {
        return self.textField?.text
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        delegate?.textChanged(textField.text, inCell: self)
    }
}
