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
            let imageData = NSData(contentsOfURL: url)
            if imageData != nil {
                //turn bits into image
                image = UIImage(data: imageData!)
            } else {
                image = nil
            }
        }
    }
}
