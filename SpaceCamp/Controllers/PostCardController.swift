//
//  PostCardController.swift
//  SpaceCamp
//
//  Created by Ehsan on 19/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import MessageUI
import AVFoundation
import StoreKit

class PostCardController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postCardField: UITextField!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    
    var player: AVAudioPlayer?
    
    var postCardImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postCardField.delegate = self
        emailField.delegate = self
        
        downloadButton.isHidden = true
        emailButton.isHidden = true
        emailField.isHidden = true
        
        emailButton.roundButton()
        downloadButton.roundButton()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let path = Bundle.main.path(forResource: "PhotoSentDownloaded", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.setVolume(0.9, fadeDuration: 0)
        } catch {
            print("could not load file")
        }
        
        
        
    }
    
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func downloadAction(_ sender: UIButton) {
        //UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            // we got back an error!
            let err = UIAlertController(title: "Error", message: "Unable to save!", preferredStyle: .alert)
            err.addAction(UIAlertAction(title: "OK", style: .default))
            present(err, animated: true)
        } else {
            player?.play()
            downloadFeedback()
        }
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
            UIView.transition(with: imageView, duration: 0.6, options: .transitionFlipFromBottom, animations: {
                self.imageView.image = self.textOverImage(text: newText, image: self.postCardImage, at: CGPoint(x: 40, y: 40))
            }, completion: nil)
        }
        

        UIView.transition(with: downloadButton, duration: 1.0, options: .transitionFlipFromBottom, animations: {
            self.downloadButton.isHidden = false
        }, completion: nil)
        
        UIView.transition(with: emailButton, duration: 1.0, options: .transitionFlipFromBottom, animations: {
            self.emailButton.isHidden = false
        }, completion: nil)
        
        UIView.transition(with: emailField, duration: 1.0, options: .transitionFlipFromBottom, animations: {
            self.emailField.isHidden = false
        }, completion: nil)
        
    
        self.view.endEditing(true)
        
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
    
    
    // function to send email
    func sendEmail(to address: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([address])
            mail.setSubject("Mars Rover PostCard from SpaceCamp")
            mail.setMessageBody("Warm wishes from SpaceCamp.\nHere is your Mars Rover PostCard. If you enjoy the app please give it five star rate in App Store. Have a lovely day...", isHTML: true)
            
            guard let image = imageView.image else {
                return
            }
            
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return
            }
            
            mail.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: "MarsRoverPostCard")
            
            present(mail, animated: true)
        } else {
            // alert the user he can't send email
            showUnableToSendEmailAlert()
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        player?.play()
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
        controller.dismiss(animated: true)
    }
    
    
}
