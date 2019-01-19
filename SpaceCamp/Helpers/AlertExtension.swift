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
        dismiss(animated: true, completion: completion)
    }
    
    
    func showNoPhotoAlert() {
        let alert = UIAlertController(title: "No Photos", message: "Unfortunately Mars Rover did not take any photos on your chosen date! Please try another date", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
