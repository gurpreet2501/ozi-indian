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

 
    
    //Data received from MenuVC
    var idReceived:String!
    var titleReceived:String!
    

    var newsTitle:String!
    var newsImages:String!
    var newsDescription:String!
    
    var arrNewsTitle = NSMutableArray()
    var arrNewsImages = NSMutableArray()
    var arrNewsDescription = NSMutableArray()
    
    
    //Data to be sent to DetailVC
    var newsTitleToSend:String!
    var newsImageToSend:String!
    var newsDescriptionToSend:String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
            if self.titleReceived != nil
            {
                print(self.titleReceived)
                self.navigationItem.title = self.titleReceived
            }
        
       checkInternet()
        
    }

    
    func checkInternet()
    {
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            fetch()
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

    func fetch()
    {
        if idReceived != nil
        {
            fetchCategoryNews(idReceived)
        }
        else
        {
            fetchAllNews()
        }

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
        return 12.0
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCELL") as! CustomTVCHome
        
         cell.lbl.text = arrNewsTitle[indexPath.section]  as? String
        
        let url = NSURL(string: arrNewsImages[indexPath.section] as! String)
        cell.imgView.sd_setImageWithURL(url)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell :\(indexPath.section)")
        
        newsTitleToSend = arrNewsTitle[indexPath.section]  as? String
        newsImageToSend = arrNewsImages[indexPath.section] as? String
        newsDescriptionToSend = arrNewsDescription[indexPath.section] as? String
        performSegueWithIdentifier("HomeToDetail", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "HomeToDetail") {
            // initialize new view controller and cast it as your view controller
            let detailVC = segue.destinationViewController as? DetailVC
            
            detailVC?.newsTitleReceived = newsTitleToSend
            detailVC?.newsImageReceived = newsImageToSend
            detailVC?.newsDescriptionReceived = newsDescriptionToSend
            
        }
    }
    
    
    //THIS FUNCTION IS TO FETCH ALL THE NEWS FOR THE HOME PAGE
    func fetchAllNews()
    {
   
        if self.navigationItem.title == "Home"
        {
            let nsUrl = NSURL(string: "http://oziindian.tv/api/posts/all")
            let nsData = NSData(contentsOfURL: nsUrl!)
            
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(nsData!, options: .MutableContainers) as! NSArray
                //print(json)
                print("------------")
                
                for var i=0 ; i < json.count ; i++
                {
                            newsTitle = json[i].valueForKey("title") as! String
                            arrNewsTitle.addObject(newsTitle)
                    
                             newsImages = json[i].valueForKey("image") as! String
                             arrNewsImages.addObject(newsImages)
                    
                            newsDescription = json[i].valueForKey("description") as! String
                            arrNewsDescription.addObject(newsDescription)
                    
                }
                print("-----------------------------------")
                print("News Details for All News i.e. Home")
                print(arrNewsTitle)
                print("++++++++++++")
                print(arrNewsImages)
                print("-----------------------------------")
               // print(arrNewsDescription)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.homeNewsTV.reloadData()
                })
                
            }//do
                
            catch
            {
                
            }//catch
       
        }//if

            
    }//apiCall
        
    
    
    //THIS FUNCTION IS TO FETCH NEWS ACCORDING TO THE CATEGORY ID - THIS WILL BE EXECUTED FOR INDIAN, AUSTRALIAN, INTERNATIONAL AND ANY FUTURE ADDITIONS IN THE CATEGORIES LIST
    func fetchCategoryNews(categoryid : String)
    {
        
        // Code to hit the web service and getting the response
        let nsUrl = NSURL(string: "http://oziindian.tv/api/category/posts/\(categoryid)")
        print(nsUrl)
        let nsCatData = NSData(contentsOfURL: nsUrl!)
        
        do
        {
          let json = try NSJSONSerialization.JSONObjectWithData(nsCatData!, options: .MutableContainers) as! NSArray
           
            // print(json)
            print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
            
            let news = json.valueForKey("newsmaster")
            
            
            let titles = news.valueForKey("title") as! NSArray
            //print(titles)
                for var i = 0 ; i < titles[0].count ; i++
                {
                    let textList = titles[0] as! NSArray
                    self.arrNewsTitle.addObject(textList[i])
                }
            
            let images = news.valueForKey("image") as! NSArray
            //print(images)
                for var i = 0 ; i < images[0].count ; i++
                {
                    let imageList = images[0] as! NSArray
                    self.arrNewsImages.addObject(imageList[i])
                }
            
            let details = news.valueForKey("description") as! NSArray
            //print(details)
                for var i = 0 ; i < details[0].count ; i++
                {
                    let detailList = details[0] as! NSArray
                    self.arrNewsDescription.addObject(detailList[i])
                }
            
            
            print("*****************************************")
            print("News Details for category id - \(categoryid)")
            print(arrNewsTitle)
            print("***********")
            print(arrNewsImages)
            print("*****************************************")
          //  print(arrNewsDescription)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.homeNewsTV.reloadData()
            })
            
          
        }//do
            
        catch
        {
            
        }//catch
        
    } //apiCallWithId
    
    
    
    }   //class ends
    






