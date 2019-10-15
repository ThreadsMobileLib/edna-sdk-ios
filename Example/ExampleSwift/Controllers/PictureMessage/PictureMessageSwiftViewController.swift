//
//  PictureMessageSwiftViewController.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads

class PictureMessageSwiftViewController: PictureMessageViewController {

    override func sendOutsideImageMessage(with image: UIImage) {
        startAnimating()
        Threads.threads().sendMessage(with: image) { [weak self] (isSuccess, error) in
            self?.stopAnimating()
            if let error = error {
                self?.presentFailedSubmissionOutsideMessageAlertWithError(error)
            } else if isSuccess {
                self?.presentSuccessfulySubmitedOutsideMessageAlert()
            }
        }
    }

}
