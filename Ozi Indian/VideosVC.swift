//
//  VideosVC.swift
//  Ozi Indian
//
//  Created by Gurpreet on 20/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class VideosVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var VideosTV: UITableView!
    var titleReceived:String!
    
    var videosTitle:String!
    var videosImage:String!
    var videosURL:String!
    
    var arrVideosTitle = NSMutableArray()
    var arrVideosImage = NSMutableArray()
     var arrVideosURL = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = titleReceived
       
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.VideosTV.hidden = true
            self.progressHudStart()
        })
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.checkInternet()
        })
        
        
    }

    func progressHudStart()
    {
        let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true);
        
        spinnerActivity.label.text = "Loading";
        
        //spinnerActivity.detailsLabel.text = "Please Wait !";
        
        spinnerActivity.userInteractionEnabled = false;
    }
    
    func progressHudStop()
    {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }

    
    
    func checkInternet()
    {
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
             fetchVideos()
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertControllerStyle.Alert)
            let okbtn = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                self.checkInternet()
            })
            alert.addAction(okbtn)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }//check internet
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonTapped(sender: UIBarButtonItem) {
        
                self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrVideosTitle.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideosCELL") as! CustomTVCHome
        
        cell.lblVideosTitle.text = arrVideosTitle[indexPath.section]  as? String
        
        let url = NSURL(string: arrVideosImage[indexPath.section] as! String)
        cell.imgVideosImage.sd_setImageWithURL(url)
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
         print("You selected cell :\(indexPath.section)")
       
        videosTitle = arrVideosTitle[indexPath.section]  as? String
        videosURL = arrVideosURL[indexPath.section] as? String
        performSegueWithIdentifier("VideosToPlayVideos", sender: self)
        
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "VideosToPlayVideos") {
            let playVideoVC = segue.destinationViewController as? PlayVideoVC
            playVideoVC?.videoTitleReceived = videosTitle
            playVideoVC?.videoURLReceived = videosURL
        }
    }

    
    
    func fetchVideos()
    {
        
        let nsUrl = NSURL(string: "http://oziindian.tv/api/videos/all")
        let nsData = NSData(contentsOfURL: nsUrl!)
        
        do
        {
            let json = try NSJSONSerialization.JSONObjectWithData(nsData!, options: .MutableContainers) as! NSArray
            print(json)
            print("------------")
            
            for var i=0 ; i < json.count ; i++
            {
                videosTitle = json[i].valueForKey("title") as! String
                arrVideosTitle.addObject(videosTitle)
                
                videosImage = json[i].valueForKey("videoimage") as! String
                arrVideosImage.addObject(videosImage)
                
                videosURL = json[i].valueForKey("videourl") as! String
                arrVideosURL.addObject(videosURL)
                
            }
            print("---------------------")
            print(arrVideosTitle)
            print("++++++++++++")
            print(arrVideosImage)
            print("---------------------")
            print(arrVideosURL)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.VideosTV.reloadData()
                self.progressHudStop()
                self.VideosTV.hidden = false
            })
            
        }//do
            
        catch
        {
            
        }//catch

        
    
    }//fetchVideos
    
    
    
    
}
