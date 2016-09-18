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

    var newsTitle:NSString!
    var newsImages:NSString!
    
    var arrNewsTitle = NSMutableArray()
    var arrNewsImages = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiCall()
        
  
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
        
        let url = NSURL(string: self.arrNewsImages[indexPath.section] as! String)
        cell.imgView.sd_setImageWithURL(url)
        
        return cell
    }
    
    
    func apiCall()
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
                
            }//do
                
            catch
            {
                
            }//catch
            
        


            
    }
        
        
        
    } //apiCall
    

    
    
    


