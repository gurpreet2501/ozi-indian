//
//  ViewController.swift
//  Ozi Indian
//
//  Created by Gurpreet on 10/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit


class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var homeNewsTV: UITableView!

    var idReceived:String!
    var titleReceived:String!
    
    var newsTitle:NSString!
    var newsImages:NSString!
    
    var arrNewsTitle = NSMutableArray()
    var arrNewsImages = NSMutableArray()
    
    var a = NSUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        if titleReceived != nil
        {
        print(titleReceived)
        self.navigationItem.title = titleReceived
        }
        
        if idReceived != nil
        {
            print(idReceived)
            apiCallWithId(idReceived)
            
        }
//      if  NSUserDefaults.standardUserDefaults().boolForKey("DATAPRESENT") == false
//      {
        
//      }
        else
        {
        apiCall()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuTapped(sender: UIBarButtonItem) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrNewsTitle.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCELL") as! CustomTVCHome
        
      
         cell.lbl.text = arrNewsTitle[indexPath.section]  as? String
        
//        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
//            print(self)
//        }
        
        
//        let url = NSURL(string: arrNewsImages[indexPath.section] as! String)
//        cell.imgView.sd_setImageWithURL(url)
        
        return cell
    }
    
    
    func apiCall()
    {
        
        print(self.navigationItem.title)
        
        if self.navigationItem.title == "Home"
        {
            // Code to hit the web service and getting the response
            let nsUrl = NSURL(string: "http://oziindian.tv/api/posts/all")
            let nsData = NSData(contentsOfURL: nsUrl!)
            
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(nsData!, options: .MutableContainers) as! NSArray
                print(json)
                print("------------")
                
                for var i=0 ; i < json.count ; i++
                {
                            newsTitle = json[i].valueForKey("title") as! NSString
                            self.arrNewsTitle.addObject(newsTitle)
                    
                             newsImages = json[i].valueForKey("image") as! NSString
                             arrNewsImages.addObject(newsImages)
                }
                print("---------------------")
                print(arrNewsTitle)
                print("++++++++++++")
                print(arrNewsImages)
                
                homeNewsTV.reloadData()
                
//                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "DATAPRESENT")
                
            }//do
                
            catch
            {
                
            }//catch
       
        }//if

            
    }//apiCall
        
    
    
    
    
    func apiCallWithId(categoryid : String)
    {
        
        // Code to hit the web service and getting the response
        let nsUrl = NSURL(string: "http://oziindian.tv/api/category/posts/\(categoryid)")
        print(nsUrl)
        let nsCatData = NSData(contentsOfURL: nsUrl!)
        
        do
        {
            let json = try NSJSONSerialization.JSONObjectWithData(nsCatData!, options: .MutableContainers) as! NSArray
           // print(json)
            print("---------------------------------------------------------------------------------------------------")
            print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
            
            let newsMaster = json.objectAtIndex(0).valueForKey("newsmaster")
            print(newsMaster)
            let titles = newsMaster!.valueForKey("title") as! NSArray
            print(titles)
            arrNewsTitle.addObject(titles)
            
            let images = newsMaster!.valueForKey("image") as! NSArray
            print(images)
            arrNewsImages.addObject(images)
            
            
            homeNewsTV.reloadData()
            
            //                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "DATAPRESENT")
            
        }//do
            
        catch
        {
            
        }//catch
        
        
        
        
    } //apiCallWithId
    
    
    
    
    
    }   //class ends
    






