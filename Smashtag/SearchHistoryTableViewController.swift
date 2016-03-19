//
//  SearchHistoryTableViewController.swift
//  Smashtag
//
//  Created by Angelo Wong on 3/17/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class SearchHistoryTableViewController: UITableViewController {
    
    struct Keys {
        static let History = "SearchHistoryTableViewController.History"
    }
    
    private struct ReuseIdentifier {
        static let Cell = "Search"
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    private var searchHistory: [String] = [] {
        willSet {
//            print("this needs to be here for append not to crash")
        }
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        if let history = defaults.objectForKey(Keys.History) as? [String] {
            searchHistory = history
        }
        searchHistory = searchHistory.reverse()
        print(searchHistory)

    }
    
    // MARK: - Segue into search
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Do Search" {
            let svc = segue.destinationViewController as! TweetTableViewController
            let cell = sender as! SearchHistoryTableViewCell
            svc.searchText = cell.searchText!.text
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        print(searchHistory.count)
        return searchHistory.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> SearchHistoryTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier.Cell, forIndexPath: indexPath) as! SearchHistoryTableViewCell
        cell.searchText.text = searchHistory[indexPath.row]

        return cell
    }


    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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
