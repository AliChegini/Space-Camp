//
//  PostCardController.swift
//  SpaceCamp
//
//  Created by Ehsan on 19/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import MessageUI

class PostCardController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postCardField: UITextField!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    var postCardImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postCardField.delegate = self
        emailField.delegate = self
        
        downloadButton.isHidden = true
        emailButton.isHidden = true
        emailField.isHidden = true
        resultLabel.isHidden = true
        
        emailButton.roundButton()
        downloadButton.roundButton()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func downloadAction(_ sender: UIButton) {
        
    }
    
    
    @IBAction func sendToEmail(_ sender: UIButton) {
        if let email = emailField.text {
            sendEmail(to: email)
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            // Move the view up, so keyboard have space
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            // Move the view down
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let newText = postCardField.text {
            imageView.image = textOverImage(text: newText, image: postCardImage, at: CGPoint(x: 40, y: 40))
        }
        
        self.view.endEditing(true)

        downloadButton.isHidden = false
        emailButton.isHidden = false
        emailField.isHidden = false
        
        return false
    }
    
    
    // function to write text over image
    func textOverImage(text: String, image: UIImage, at point: CGPoint) -> UIImage {
        let textColor = UIColor.red
        guard let textFont = UIFont(name: "Rockwell", size: (image.size.width/20.0)) else {
            return UIImage()
        }
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, true, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    // Think about removing this feautre
    
    // function to send email
    func sendEmail(to address: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([address])
            mail.setSubject("PostCard from SpaceCamp")
            mail.setMessageBody("Warm wishes from SpaceCamp.\nHere is your PostCard. If you enjoy the app please give it five star in AppStore. Have a lovaely day.", isHTML: true)
            // TODO: attatch the image later and think about removing this option. User may get paranoid and delete the app
            //mail.addAttachmentData(<#T##attachment: Data##Data#>, mimeType: <#T##String#>, fileName: <#T##String#>)
            
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        resultLabel.isHidden = false
        resultLabel.text = "Your Postcard has been successfully sent"
        controller.dismiss(animated: true)
    }
    
    
}
