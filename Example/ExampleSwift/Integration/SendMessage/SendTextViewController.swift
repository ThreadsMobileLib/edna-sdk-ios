//
//  TextMessageSwiftViewController.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads

class SendTextViewController: UITableViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBarButton: UIBarButtonItem!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        
        if let text = self.textView.text {
            self.sendMessage(withText:text)
        }
    }

    func sendMessage(withText text: String) {
        
        startAnimating()
        Threads.threads().sendMessage(withText: text) { [weak self] (error) in
            self?.stopAnimating()
            if let error = error {
                self?.presentFailedSubmissionOutsideMessageAlert(withError: error)
            } else {
                self?.presentSuccessfulySubmitedOutsideMessageAlert()
            }
        }
    }

    func presentSuccessfulySubmitedOutsideMessageAlert() {
        
        let alert = UIAlertController.init(title: NSLocalizedString("Success", comment: ""),
                                           message: NSLocalizedString("Your message successfuly submited.", comment:  ""),
                                           preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (action) in
            self.textView.text = nil
        }))
        present(alert, animated: true, completion: nil)
    }

    func presentFailedSubmissionOutsideMessageAlert(withError error: Error) {
        
        let errorDesc = (error as NSError).userInfo["error_description"] as? String
        let alert = UIAlertController.init(title: NSLocalizedString("Failed", comment: ""),
                                           message: errorDesc,
                                           preferredStyle: .alert)

        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func startAnimating() {
        let item = UIBarButtonItem.init(customView: activityView)
        self.navigationItem.rightBarButtonItem = item
        activityView.startAnimating()
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = false;
    }

    func stopAnimating() {
        activityView.stopAnimating()
        self.navigationItem.rightBarButtonItem = self.sendBarButton
        self.view.isUserInteractionEnabled = true;
    }
}
