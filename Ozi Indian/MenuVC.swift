//
//  MenuVC.swift
//  Ozi Indian
//
//  Created by Gurpreet on 12/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   @IBOutlet weak var menuTableView: UITableView!
   
    var json:NSArray!
    var categoriesTitle:String!
    var idToSend:String!

    var arrCategoriesTitle = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        apiCallCategoriesList()
 
    }
    
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
        return 7.0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCELL") as! CustomTVCHome!

        cell.lblMenuCategories.text = arrCategoriesTitle[indexPath.section] as? String
        
        return cell
    }
    
    
    func apiCallCategoriesList()
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
            
           menuTableView.reloadData()
            
        }//do
            
        catch
        {
            
        }//catch
     
    }//api call
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("Home") as! HomeVC
        
        categoriesTitle =  json[indexPath.section].valueForKey("title") as! String
        viewController.titleReceived = categoriesTitle
        print(categoriesTitle)
        
        

        if let idToSend =  json[indexPath.section].valueForKey("id") as? String
        {
            print("ID is :\(idToSend)")
            viewController.idReceived = idToSend
        }
        
        let navigationController = self.mm_drawerController.centerViewController as! UINavigationController

            self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: { (Bool) -> Void in
                navigationController.viewControllers = [viewController]
                
            })
       
        
       
  
    }
}
