//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Angelo Wong on 3/13/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    struct Color {
        static let screennameColor = UIColor.redColor()
        static let htColor = UIColor.brownColor()
        static let urlColor = UIColor.blueColor()
        static let posterColor = UIColor.purpleColor()
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
    let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)

    
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet
        {

            tweetTextLabel?.text = tweet.text
            
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
                highlightIndicators(tweetTextLabel, hashtagColor: Color.htColor, screennameColor: Color.screennameColor, urlColor:  Color.urlColor)
            }
            
            
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            //TODO need to fix this
            if let profileImageURL = tweet.user.profileImageURL {
                dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                    if let imageData = NSData(contentsOfURL: profileImageURL) {
                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            self.tweetProfileImageView?.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }

    }
    // MARK: - Color highlight Extension
    private func highlightIndicators(label: UILabel, hashtagColor: UIColor, screennameColor: UIColor, urlColor: UIColor) {
        let ht = tweet!.hashtags
        let urls = tweet!.urls
        let mentions = tweet!.userMentions
        let attributedText = NSMutableAttributedString(string: label.text!)
        for i in 0..<ht.count {
            attributedText.addAttribute(NSForegroundColorAttributeName, value: hashtagColor, range: ht[i].nsrange)
        }
        for i in 0..<urls.count {
            attributedText.addAttribute(NSForegroundColorAttributeName, value: urlColor, range: urls[i].nsrange)
        }
        for i in 0..<mentions.count {
            attributedText.addAttribute(NSForegroundColorAttributeName, value: screennameColor, range: mentions[i].nsrange)
        }
        label.attributedText = attributedText
    }
}



//private func getIndexTuple(keywordArray: IndexedKeyword) -> (start: Int, end: Int) {
//    let stringTuple = keywordArray.description.characters.split{$0 == "("}.map(String.init)[1]
//    var stringNum = stringTuple.characters.split{$0 == ","}.map(String.init)
//    stringNum[1].removeAtIndex(stringNum[1].endIndex.predecessor())
//    stringNum[1].removeAtIndex(stringNum[1].startIndex)
//    let start = Int(stringNum[0])!
//    let end = Int(stringNum[1])!
//    return (start,end)
//}