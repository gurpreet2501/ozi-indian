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
    var dataDict = NSMutableDictionary()

    var news:String?
    var arrNews = NSMutableArray()
    var arrPics = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiCall()
        
        arrPics = ["http://67.media.tumblr.com//995e48c5341b746101c82710d78014a3//tumblr_n0u1m1wGO71rcyxhzo1_75sq.gif", "http://67.media.tumblr.com//3b45ba03988103c2eeee0ba707023931//tumblr_n0j3tfqLLn1rcyxhzo1_250.gif", "http://67.media.tumblr.com//5560c83257e423dbe3a706d023815b21//tumblr_mzwrcvU8oV1rcyxhzo5_r1_250.gif", "http://67.media.tumblr.com//995e48c5341b746101c82710d78014a3//tumblr_n0u1m1wGO71rcyxhzo1_75sq.gif", "http://67.media.tumblr.com//67f173238c5c70bf4ea26c3f20546390//tumblr_mhn7gs894X1rcyxhzo1_r3_250.gif", "http://67.media.tumblr.com//3b45ba03988103c2eeee0ba707023931//tumblr_n0j3tfqLLn1rcyxhzo1_250.gif"]
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuTapped(sender: UIBarButtonItem) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNews.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCELL") as! CustomTVCHome
        
       cell.lbl.text = self.arrNews[indexPath.row] as? String
        
//        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
//            print(self)
//        }
    
        
        
        
        let url = NSURL(string: arrPics[indexPath.row] as! String)
        
        cell.imgView.sd_setImageWithURL(url)
        

        return cell
    }
    
    
    func apiCall()
    {
            // Code to hit the web service and getting the response
        let url = NSURL(string: "http://theappguruz.in//Apps/iOS/Temp/json.php")
        let request = NSURLRequest(URL: url!)
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
        {(response, data, error) in
            let dict: NSDictionary!=(try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary

            print("\(dict)")
            print("--------------------")
            
            for var i=0 ; i < (dict.valueForKey("MONDAY") as! NSArray).count ; i++
            {
                self.arrNews.addObject((dict.valueForKey("MONDAY") as! NSArray).objectAtIndex(i).valueForKey("DETAILS")!)
            }
            print("--------------------")
            for var i=0 ; i < (dict.valueForKey("TUESDAY") as! NSArray).count ; i++
            {
                self.arrNews.addObject((dict.valueForKey("TUESDAY") as! NSArray).objectAtIndex(i).valueForKey("DETAILS")!)
            }
            print("--------------------")
            for var i=0 ; i < (dict.valueForKey("WEDNESDAY") as! NSArray).count ; i++
            {
                self.arrNews.addObject((dict.valueForKey("WEDNESDAY") as! NSArray).objectAtIndex(i).valueForKey("DETAILS")!)
            }
        
            print(self.arrNews)
     
        
                self.homeNewsTV.reloadData()
            
    }
        
        
        
    } //apiCall
    

    
    
    
}

