//
//  AlertExtension.swift
//  SpaceCamp
//
//  Created by Ehsan on 19/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import StoreKit

extension UIViewController {
    
    // function to start activity indicator and block user interactions
    func startActivityIndicator() {
        // set activity indicator state to On
        StaticProperties.isActivityIndicatorOn = true
        let alert = UIAlertController(title: nil, message: "Fetching Data...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // function to stop activity indicator and allow user interactions
    func stopActivityIndicator(completion: @escaping () -> Void) {
        StaticProperties.isActivityIndicatorOn = false
        dismiss(animated: true, completion: completion)
    }
    
    
    // function to provide feedback for timeout
    func timeOutFeedback() {
        let alert = UIAlertController(title: "Something Went Wrong", message: "You might have a slow connection, or API might not be responding at the moment. Please wait for a while and try again...", preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    // function to alert for no photos
    func showNoPhotoAlert() {
        let alert = UIAlertController(title: "No Photos for this Date", message: "Mars Rover did not take any photos on your chosen date\nPlease try another date", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
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
        let alert = UIAlertController(title: nil, message: "You have downloaded the PostCard successfully", preferredStyle: .alert)
        
        present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.dismiss(animated: true)
            // if for user review
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    
    // No Internet conncetion Alert
    func showNotConnectedToInternet() {
        let alert = UIAlertController(title: "No Internet Conncetion", message: "You are not connected to Internet, Please check your connection and try again...", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}
