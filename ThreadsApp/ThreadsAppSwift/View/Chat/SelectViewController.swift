//
//  SelectViewController.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 16/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import UIKit


class SelectViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selects : Array<THRDesign>?
    
    weak var delegate : SelectCellDelegate?
    
    var tableView : UITableView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Design"
        self.configureTableView()
    }
    
    //MARK: - Configure
    
    func configureTableView() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        self.view.addSubview(tableView)
    }
    
    //MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let design = self.selects![indexPath.row]
        cell.textLabel?.text = SelectCell.designName(design: design)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.selectCellDidSelect(design: self.selects![indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
