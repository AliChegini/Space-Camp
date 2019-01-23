//
//  AlertExtension.swift
//  SpaceCamp
//
//  Created by Ehsan on 19/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


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
        
        present(alert, animated: true)
    }
    
    
    // function to stop activity indicator and allow user interactions
    func stopActivityIndicator(completion: @escaping () -> Void) {
        StaticProperties.isActivityIndicatorOn = false
        dismiss(animated: true, completion: completion)
    }
    
    
    // No Internet conncetion Alert
    func notConnectedToInternetAlert(completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "No Internet Conncetion", message: "You are not connected to Internet, Please check your connection and try again...", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.dismiss(animated: true)
            completion()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
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
    
    
    // function to provide feedback when reaching API limit.
    func apiLimitAlert() {
        let alert = UIAlertController(title: "Busy Hour", message: "Lot of users are using the app at the moment. Your interest in SpaceCamp is highly appreciated, but due to API limitation SpaceCamp can only handle 1000 requests per hour. Please try using the app after 60 minutes", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.dismiss(animated: true)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}



extension UIButton {
    func roundButton() {
        self.layer.cornerRadius = 10
    }
}
