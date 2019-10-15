//
//  TextMessageSwiftViewController.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads

class TextMessageSwiftViewController: TextMessageViewController {

    override func sendMessage(withText text: String) {
        startAnimating()
        Threads.threads().sendMessage(withText: text) { [weak self] (isSuccess, error) in
            self?.stopAnimating()
            if let error = error {
                self?.presentFailedSubmissionOutsideMessageAlertWithError(error)
            } else if isSuccess {
                self?.presentSuccessfulySubmitedOutsideMessageAlert()
            }
        }
    }

}
