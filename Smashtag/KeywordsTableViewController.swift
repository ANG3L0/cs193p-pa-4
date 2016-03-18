//
//  KeywordsTableViewController.swift
//  Smashtag
//
//  Created by Angelo Wong on 3/15/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class KeywordsTableViewController: UITableViewController {
    
    var urls: [Tweet.IndexedKeyword] = []
    var userMentions: [Tweet.IndexedKeyword] = []
    var hashtags: [Tweet.IndexedKeyword] = []
    var images: [MediaItem] = []
    
    //why dictionary? Allows for arbitrary assignment of sectioning
    private var mediaSharing: [Medium] = []

    
    // MARK: - Private structural declarations
    private enum TweetElement {
        case Image(NSURL, Double)
        case StringElement(String, UIColor)
    }
    
    private struct Medium {
        var count: Int
        var header: String?
        var data: [TweetElement]
    }
    
    private struct Constants {
        static let ImageTitle = "IMAGES"
        static let UrlTitle = "LINKS"
        static let HtTitle = "HASHTAGS"
        static let MentionTitle = "MENTIONS"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Goback To Tweets" {
            if let cell = sender as? KeywordsTableViewCell {
                if let tweetMVC = segue.destinationViewController as? TweetTableViewController {
                    if let text = cell.keywordLabel.text {
                        if text.hasPrefix("@") || text.hasPrefix("#") {
                            tweetMVC.searchText = cell.keywordLabel.text
                        } else {
                            let url = NSURL(string: text)
                            UIApplication.sharedApplication().openURL(url!) //would not be marked URL without http://
                        }
                    }
                    
                }
            }
        } else if let cell = sender as? ImagesTableViewCell {
            let imageMVC = segue.destinationViewController as! ImageViewController
            imageMVC.imageAspectRatio = cell.pic.bounds.width / cell.pic.bounds.height
            imageMVC.image = cell.pic.image
            print(imageMVC.imageAspectRatio)
        }
    }

    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tweet Deetz"
        let urlCount = urls.count
        let hashtagCount = hashtags.count
        let userMentionCount = userMentions.count
        let imagesCount = images.count
        if imagesCount > 0 { mediaSharing.append(Medium(count: imagesCount, header: imagesCount > 0 ? Constants.ImageTitle : nil, data: imageData(images))) }
        if urlCount > 0 { mediaSharing.append(Medium(count: urlCount, header: urlCount > 0 ? Constants.UrlTitle  : nil, data: stringData(urls, color: TweetTableViewCell.Color.urlColor))) }
        if hashtagCount > 0 { mediaSharing.append(Medium(count: hashtagCount, header: hashtagCount > 0 ? Constants.HtTitle : nil, data: stringData(hashtags, color: TweetTableViewCell.Color.htColor))) }
        if userMentionCount > 0 { mediaSharing.append(Medium(count: userMentionCount, header: userMentionCount > 0 ? Constants.MentionTitle : nil, data: stringData(userMentions, color: TweetTableViewCell.Color.screennameColor))) }

    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaSharing[section].count
    }

    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mediaSharing[section].header
    }
    
    private struct Storyboard {
        static let KeywordsReuseIdentifier = "Keywords"
        static let ImagesReuseIdentifier = "Images"
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let medium = mediaSharing[indexPath.section].data[indexPath.row]
        switch medium {
        case .StringElement(let string, let color):
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.KeywordsReuseIdentifier, forIndexPath: indexPath) as! KeywordsTableViewCell
            cell.keywordLabel.text = string
            let attrStr =  NSMutableAttributedString(string: string)
            let range = NSMakeRange(0, string.characters.count)
            attrStr.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
            cell.keywordLabel.attributedText = attrStr
            return cell
        case .Image(let url, _):
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.ImagesReuseIdentifier, forIndexPath: indexPath) as! ImagesTableViewCell
            cell.url = url
            return cell
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mediaSharing.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let medium = mediaSharing[indexPath.section].data[indexPath.row]
        switch medium {
        case .StringElement(_, _):
            return UITableViewAutomaticDimension
        case .Image(_, let aspectRatio):
            return tableView.bounds.size.width / CGFloat(aspectRatio)
        }
    }
    
    // MARK: - private utility functions
    private func stringData(data: [Tweet.IndexedKeyword], color: UIColor) -> [TweetElement] {
        var tweetElement: [TweetElement] = []
        for datum in data {
            tweetElement.append(TweetElement.StringElement(datum.keyword, color))
        }
        return tweetElement
    }
    private func imageData(data: [MediaItem]) -> [TweetElement] {
        var tweetImage: [TweetElement] = []
        for datum in data {
            tweetImage.append(TweetElement.Image(datum.url, datum.aspectRatio))
        }
        return tweetImage
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
