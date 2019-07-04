//
//  SwitchCell.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 16/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import UIKit

protocol SwitchCellDelegate: class {
    func switchCell(_ cell: SwitchCell, switched: Bool)
}

class SwitchCell : UITableViewCell {
    
    weak var delegate: SwitchCellDelegate?
    
    var type : CellType = .DebugMode
    
    @IBOutlet weak var placeholderLabel: UILabel!
    
    @IBOutlet weak var switcher: UISwitch!
    
    // MARK: - Initialize
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    //MARK: - Configuring

    func construct() {
        self.placeholderLabel.text = CellTypeHelper.getCellText(forType: self.type)
    }
    
    @IBAction func switched(_ sender: UISwitch) {
        delegate?.switchCell(self, switched: switcher.isOn)
    }
}
