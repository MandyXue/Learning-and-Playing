//
//  ImageViewController.swift
//  Cassini
//
//  Created by MandyXue on 15/9/10.
//  Copyright (c) 2015年 MandyXue. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: model
    var imageURL: NSURL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    //MARK: properties
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            // you need to protect against the cases where outlets might be nil
            // so add a '?'
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    //MARK: outlets
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: delegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    //MARK: methods
    private func fetchImage(){
        if let url = imageURL {
            spinner?.startAnimating()
            //multithreading
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    // considering if the image comes back after you ask for the second pic
                    if url == self.imageURL {
                        if imageData != nil {
                            //turn bits into image
                            self.image = UIImage(data: imageData!)
                        } else {
                            self.image = nil
                        }
                    }
                }
            }
        }
    }
}
