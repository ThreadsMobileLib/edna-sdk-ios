//
//  ButtonCell.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 16/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import UIKit

protocol ButtonCellDelegate: class {
    func buttonCellClicked(_ cell: ButtonCell)
}

class ButtonCell : UITableViewCell {
    
    var type: CellType = .FullChat
    
    weak var delegate: ButtonCellDelegate?
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func construct() {
        self.button.setTitle(CellTypeHelper.getCellText(forType: self.type), for: .normal)
    }
    
    @IBAction func clicked(_ sender: Any) {    
        delegate?.buttonCellClicked(self)
    }
    
}
