# Project 4 - Smashtag Mentions

## Summary
Here, we do a bunch of stuff using Tweet data.  Mainly to learn about how to go around a bunch of different MVCs with a tab controller and segue'ing up the wazoo.  Also, utilizing TableView.

## Required Tasks
1. [x] Enhance Smashtag from lecture to highlight (in a different color for each) hashtags, urls and user screen names mentioned in the text of a Tweet (these are known as “mentions”). Note that mentions are already located for you in each Tweet by Twitter and show up as [IndexedKeyword]s in the Tweet class in the supplied Twitter code.
2. [x] When a user clicks on a Tweet, segue to a new UITableViewController which has four sections showing the “mentions” in the Tweet: Images, URLs, Hashtags and Users. The first section displays (one per row) any images attached to the Tweet (found in the media variable in the Tweet class). The last three show the items described in Required Task 1 (again, one per row).
3. [x] Each section in the mentions table view should have an appropriate header.
4. [x] If a section has no items in it, there should be no header visible for that section.
5. [x] If a user touches an entry for a hashtag or a user in the “mentions table view” that you created in Required Task 2 above, you should segue to show the results of searching Twitter for that hashtag or user. It should be searching for hashtags or users, not just searching for a string that is the name of the hashtag or user (e.g. search for “#stanford”, not “stanford”). The view controller to which you segue must work identically to your main Tweet-viewing view controller (TweetTableViewController).
6. [x] If the user clicks on a mentioned url in your newly created view controller, you should open up that url in Safari (see Hints below for how to do that).
7. [x] If the user clicks on an image in your newly created view controller, segue to a new MVC which lets the user scroll around and zoom in on the image. When the image first appears in the MVC, it should display zoomed (in its normal aspect ratio) to show as much of the image as possible but with no “whitespace” around it.
8. [x] Keep track of the most recent 100 Twitter searches the user has performed in your application. Add a UITabBarController to your application with a tab for searching (i.e. your main UI) and a second tab showing these most recent search terms in a table view (uniqued with most recent first). When a user clicks on a search term in the second tab, segue (stay in that same tab) to show the most recent Tweets matching that search term. Store these most recent searches permanently in NSUserDefaults so that your application doesn’t forget them if it is restarted.
9. [x] You must not block the main thread of your application with a network request at any time.
10. [x] Your application must work properly in portrait or landscape on any iPhone (this is an iPhone-only application). 

## Extra Credit
1. [x] In the Users section of your new UITableViewController, list not only users mentioned in the Tweet, but also the user who posted the Tweet in the first place.
2. [x] When you click on a user in the Users section, search not only for Tweets that mention that user, but also for Tweets which were posted by that user.
~~3. [ ] If you segue using Show (rather than Unwind), add some UI which will Unwind all the way back to the rootViewController of the UINavigationController. Even if you use Unwind (rather than Show), then if do the Collection View extra credit below using a Show segue, you might want the “unwind to root” behavior in scenes you segue to via the Collection View.~~
Did unwind since Show would be a pretty unreasonable UI.
~~4. [ ] Instead of opening urls in Safari, display them in your application by segueing to a controller with a UIWebView. You’ll have to provide at least a little bit of “browser control” UI to go along with it (e.g. a “back button”).~~
Bad practice to reinvent the wheel when you can delegate browsing to an app.  Also, just more views (i.e. WebView) so this is sort of redundant.
5. [ ] Make the “most recent searches” table be editable (i.e. let the user swipe left to delete the ones they don’t like).
~~6. [ ] Add some UI which displays a new view controller showing a UICollectionView of the first image (or all the images if you want) in all the Tweets that match the search. When a user clicks on an image in this UICollectionView, segue to showing them the Tweet.~~
Seems like a better alternative would be to embed the images in the first place, but then that defeats the purpose of having our detailed MVC when we click on the Tweet in the first place...

## Demo
TBD