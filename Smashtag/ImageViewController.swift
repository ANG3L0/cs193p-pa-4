//
//  ImageViewController.swift
//  Smashtag
//
//  Created by Angelo Wong on 3/17/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Instance vars
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            print("scroll set")
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 2.0
        }
    }
    
    private var imageView = UIImageView()
    
    private var zoomed: Bool = false
    
    var imageAspectRatio: CGFloat = 16 / 9
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            redrawImage()
            imageView.image = newValue
        }
    }
    // MARK: - Lifetime method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pic Deetz"
        scrollView.addSubview(imageView)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if !zoomed {
            redrawImage(newWidth: size.width)
        }
    }
    
    private func redrawImage(newWidth width: CGFloat = UIScreen.mainScreen().bounds.width) {
        let imageViewWidth = width
        let imageViewHeight = width / imageAspectRatio
        imageView.frame = CGRectMake(0, 0, imageViewWidth, imageViewHeight)
        scrollView?.contentSize = imageView.frame.size //optional chaining just to be safe
    }
    
    // MARK: - Delegate method
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        zoomed = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
