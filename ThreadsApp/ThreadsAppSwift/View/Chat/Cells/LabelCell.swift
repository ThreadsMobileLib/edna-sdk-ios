//
//  LabelCell.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 16/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import UIKit

class LabelCell : UITableViewCell {
    
    var type: CellType = .Version
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Initialize
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    // MARK: - Configuring
    
    func construct() {
        self.label.text = CellTypeHelper.getCellText(forType: self.type);
        
    }
}
