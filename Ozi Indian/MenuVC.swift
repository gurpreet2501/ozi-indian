//
//  MenuVC.swift
//  Ozi Indian
//
//  Created by Gurpreet on 12/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var activityIndicatorMenu: UIActivityIndicatorView!
    
    @IBOutlet weak var menuTableView: UITableView!
   
    @IBOutlet weak var lblNoInternet: UILabel!
    var json:NSArray!
    var categoriesTitle:String!
    var idToSend:String!
    
    var arrCategoriesTitle = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        // Do any additional setup after loading the view.
        if arrCategoriesTitle.count == 0
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.checkInternet()
            })
            
        }
        
    }

    
    
    override func viewDidAppear(animated: Bool) {
        if arrCategoriesTitle.count == 0
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.checkInternet()
            })
            
        }

    }
    
    
    
    func checkInternet()
    {
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.lblNoInternet.hidden = true
                self.activityIndicatorMenu.startAnimating()
            })
            
                self.fetchCategoriesList()
        } else {
            print("Internet connection FAILED")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.lblNoInternet.hidden = false
           self.menuTableView.hidden = true
                
            })
           
        }
    }//check internet

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuTapped(sender: UIBarButtonItem) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrCategoriesTitle.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.5
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 7))
//      
//            headerView.backgroundColor = UIColor.grayColor()
//    
//        return headerView
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCELL") as! CustomTVCHome!
        
        cell.lblMenuCategories.text = arrCategoriesTitle[indexPath.section] as? String
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        categoriesTitle =  json[indexPath.section].valueForKey("title") as! String
        
        
        if categoriesTitle == "Videos"
        {
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("Videos") as! VideosVC
            viewController.titleReceived = categoriesTitle
            let navigationController = self.mm_drawerController.centerViewController as! UINavigationController
            
            self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: { (Bool) -> Void in
                navigationController.viewControllers = [viewController]            })
        }//if
            
        else if categoriesTitle == "Live Tv"
        {
                        self.mm_drawerController.centerViewController as! UINavigationController
                        self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: nil)
            
                        let alertController = UIAlertController(title: "Live TV", message: "Select the type of video quality you want to play", preferredStyle: .Alert)
            
                        let lowbtn = UIAlertAction(title: "Low Quality", style: UIAlertActionStyle.Default) {
                            UIAlertAction in
                            NSLog("Low Pressed")
                            self.liveTV("http://live.wmncdn.net/oziindian/72781e965e0681e980034a778ee7067b.sdp/mono.m3u8")
                        }
            
                        let highbtn = UIAlertAction(title: "High Quality", style: UIAlertActionStyle.Default) {
                            UIAlertAction in
                            NSLog("High Pressed")
                            self.liveTV("http://live.wmncdn.net/oziindian/bbb19eae240ec100af921d511efc86a0.sdp/mono.m3u8")
                        }
            
                        let cancelbtn = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                        }
            
                        alertController.addAction(lowbtn)
                        alertController.addAction(highbtn)
                        alertController.addAction(cancelbtn)
                        self.presentViewController(alertController, animated: true, completion: nil)

        
            
        }//elseif
            
        
        else if categoriesTitle == "Contact Us"
        {
                        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContactUs") as! ContactVC
                        viewController.titleReceived = categoriesTitle
                        let navigationController = self.mm_drawerController.centerViewController as! UINavigationController
            
                        self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: { (Bool) -> Void in
                            navigationController.viewControllers = [viewController]            })

        }//else if
            
            
        else
        {
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("Home") as! HomeVC
            viewController.titleReceived = categoriesTitle
            
            if let idToSend =  json[indexPath.section].valueForKey("id") as? String
            {
                print("ID is :\(idToSend)")
                viewController.idReceived = idToSend
            }
            
            let navigationController = self.mm_drawerController.centerViewController as! UINavigationController
            
            self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: { (Bool) -> Void in
                navigationController.viewControllers = [viewController]            })
        }//else
        
        
    }
    
    
        func liveTV(liveURL : String)
        {
                let videoURL = NSURL(string: liveURL)
            let player = AVPlayer(URL: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.presentViewController(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
    
        }

    
    
    
    //THIS FUNCTION IS JUST TO FETCH THE LIST OF CATEGORIES
    func fetchCategoriesList()
    {
        let nsUrl = NSURL(string: "http://oziindian.tv/api/category/lists")
        let nsData = NSData(contentsOfURL: nsUrl!)
        
        do
        {
            json = try NSJSONSerialization.JSONObjectWithData(nsData!, options: .MutableContainers) as! NSArray
            //    print(json)
            
            
            for var i=0 ; i < json.count ; i++
            {
                categoriesTitle = json[i].valueForKey("title") as! String
                self.arrCategoriesTitle.addObject(categoriesTitle)
            }
            print("--------------------------------------")
            print(arrCategoriesTitle)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.menuTableView.reloadData()
                self.activityIndicatorMenu.stopAnimating()
                self.menuTableView.hidden = false
            })
           
            
        }//do
            
        catch
        {
            
        }//catch
        
    }//api call
    
    
}
