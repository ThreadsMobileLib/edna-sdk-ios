//
//  PictureMessageSwiftViewController.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads

class SendPictureViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var sendBarButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noImageLabel: UILabel!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendImage(_ sender: Any) {
        
        if let image = imageView.image {
            noImageLabel.textColor = UIColor.lightGray
            sendOutsideImageMessage(with: image)
        } else {
            noImageLabel.textColor = UIColor.red
            return
        }
    }

    func sendOutsideImageMessage(with image: UIImage) {
        
        startAnimating()
        Threads.threads().sendMessage(with: image) { [weak self] (error) in
            self?.stopAnimating()
            if let error = error {
                self?.presentFailedSubmissionOutsideMessageAlert(withError: error)
            } else {
                self?.presentSuccessfulySubmitedOutsideMessageAlert()
            }
        }
    }

    //MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            presentOutsideMessageImagePicker()
        }
    }

    func presentOutsideMessageImagePicker() {
        let picker = UIImagePickerController.init()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let chosenImage = info[.originalImage] as? UIImage
        
        picker.dismiss(animated: true) {
            self.imageView.image = chosenImage
        }
    }

    func presentSuccessfulySubmitedOutsideMessageAlert() {
        
        let alert = UIAlertController.init(title: NSLocalizedString("Success", comment: ""),
                                           message: NSLocalizedString("Your message successfuly submited.", comment: ""),
                                           preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { action in
            self.imageView.image = nil
        }))
        
        present(alert, animated: true, completion: nil)
    }

    func presentFailedSubmissionOutsideMessageAlert(withError error: Error) {
        
        let errorDesc = (error as NSError).userInfo["error_description"] as? String
        let alert = UIAlertController.init(title: "Failed",
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
