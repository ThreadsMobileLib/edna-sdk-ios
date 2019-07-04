//
//  SelectCell.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 16/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import UIKit

enum THRDesign : UInt, CaseIterable {
    case Default
    case BRS
}

protocol SelectCellDelegate : class {
    func selectCellDidSelect(design: THRDesign)
}

class SelectCell : UITableViewCell {
    
    var type : CellType = .Design
    weak var delegate : SelectCellDelegate?
    var selectedDesign : THRDesign = .Default
    
    @IBOutlet weak var placeholderLabel : UILabel!
    @IBOutlet weak var mainLabel : UILabel!
    
    func construct() {
        self.placeholderLabel.text = CellTypeHelper.getCellText(forType: self.type)
        self.mainLabel.text = SelectCell.designName(design: selectedDesign)
    }
    
    func showDesignController(in controller: UIViewController, withDesigns designs: Array<THRDesign>) {
        let selectVC = SelectViewController()
        selectVC.selects = designs
        selectVC.delegate = self.delegate
        
        let navController = UINavigationController()
        navController.viewControllers = [selectVC]
        
        controller.present(navController, animated: true, completion: nil)
    }
    
    class func designName(design: THRDesign) -> String {
        
        switch design {
        case .BRS:
            return "BRS"
        case .Default:
            return "Default"
        }
    }
}
