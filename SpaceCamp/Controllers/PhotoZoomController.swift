//
//  PhotoZoomController.swift
//  SpaceCamp
//
//  Created by Ehsan on 16/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class PhotoZoomController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postCardButton: UIButton!
    
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    
    
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        postCardButton.layer.cornerRadius = 10
        
        guard let photo = photo else {
            print("photo object is empty")
            return
        }
        

        imageView.image = photo
        imageView.sizeToFit()
        scrollView.contentSize = imageView.bounds.size
        updateZoomScale()
        updateConstraintsForSize(view.bounds.size)
        view.backgroundColor = UIColor.black
    }
    
    var minZoomScale: CGFloat {
        let viewSize = view.bounds.size
        let widthScale = viewSize.width / imageView.bounds.width
        let heightScale = viewSize.height / imageView.bounds.height
        
        if min(widthScale, heightScale) > 1.0 {
            return 1.0
        } else {
            return min(widthScale, heightScale)
        }
    }
    

    func updateZoomScale() {
        scrollView.minimumZoomScale = minZoomScale
        scrollView.maximumZoomScale = 1.5
        scrollView.zoomScale = minZoomScale
    }
    
    
    func updateConstraintsForSize(_ size: CGSize) {
        let verticalSpace = size.height - imageView.frame.height
        let yOffset = max(0, verticalSpace/2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width)/2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
    }
    
    
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
        
        if scrollView.zoomScale < minZoomScale {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
