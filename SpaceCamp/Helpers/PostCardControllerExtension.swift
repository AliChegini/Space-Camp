//
//  PostCardControllerExtension.swift
//  SpaceCamp
//
//  Created by Ehsan on 23/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


extension PostCardController {
    // function to alert for inability to send email
    func showUnableToSendEmailAlert() {
        let alert = UIAlertController(title: "Unable To Send Email", message: "Due to your phone's setting you can't send an email. Try donwloading the PostCard instead", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    // function to provide feedback after download
    func downloadFeedback() {
        let alert = UIAlertController(title: nil, message: "PostCard has been successfully downloaded to your phone", preferredStyle: .alert)
        
        present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.dismiss(animated: true)
        }
    }
    
    // function to provide feedback after success email
    func successEmailFeedback() {
        let alert = UIAlertController(title: nil, message: "Email has been sent successfully", preferredStyle: .alert)
        
        present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.dismiss(animated: true)
        }
    }
    
    
    // function to provide feedback after cancel email case
    func cancelEmailFeedback() {
        let alert = UIAlertController(title: nil, message: "Email was cancelled", preferredStyle: .alert)
        
        present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.dismiss(animated: true)
        }
    }
    
    
    // function to provide feedback after fail email case
    func failEmailFeedback() {
        let alert = UIAlertController(title: "Error", message: "Failed to send the email. Please try again", preferredStyle: .alert)
        
        present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.dismiss(animated: true)
        }
    }
}
