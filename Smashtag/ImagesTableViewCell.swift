//
//  ImagesTableViewCell.swift
//  Smashtag
//
//  Created by Angelo Wong on 3/16/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pic: UIImageView!
    var url = NSURL() {
        didSet {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0), { () -> Void in
                print("Make request")
                let imgData = NSData(contentsOfURL: self.url)
                dispatch_async(dispatch_get_main_queue()) {
                    print("getting request")
                    if imgData != nil {
                        self.pic.image = UIImage(data: imgData!)
                    } else {
                        self.pic.image = nil
                    }
                    
                }
            })

        }
    }

}
