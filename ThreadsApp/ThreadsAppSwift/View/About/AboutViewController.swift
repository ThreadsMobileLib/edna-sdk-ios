//
//  AboutViewController.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 14/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController : UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    private var counterValue: Int = 0;
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("unreaded_messages_test", comment:"");
        self.titleLabel.text = NSLocalizedString("unreaded_messages", comment:"");
        self.updateCouterLabel()
    }
    
    func setCounterValue(_ counterValue: Int) {
        self.counterValue = counterValue;
        self.updateCouterLabel()
        
    }
    
    func updateCouterLabel() {
        self.counterLabel?.text = String(format: "%ld", self.counterValue)
    }
}
