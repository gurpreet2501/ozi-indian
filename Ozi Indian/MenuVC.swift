//
//  MenuVC.swift
//  Ozi Indian
//
//  Created by Gurpreet on 12/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuArray:NSArray!
    
    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        menuArray = ["Home", "Contact", "Australia"]
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuTapped(sender: UIBarButtonItem) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as UITableViewCell!
        if (cell == nil) {
            cell = UITableViewCell(style:.Default, reuseIdentifier: "CELL")
        }
        cell?.textLabel?.text = menuArray[indexPath.row] as? String
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.item == 0 {
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("Home") as! HomeVC
            
            let navigationController = self.mm_drawerController.centerViewController as! UINavigationController
            
            navigationController.viewControllers = [viewController]
            
            self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        }
        if indexPath.item == 1 {
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("Contact") as! ContactVC
            
            let navigationController = self.mm_drawerController.centerViewController as! UINavigationController
            
            navigationController.viewControllers = [viewController]
            
            self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        }
        if indexPath.item == 2 {
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("Australia") as! AustraliaVC
            
            let navigationController = self.mm_drawerController.centerViewController as! UINavigationController
            
            navigationController.viewControllers = [viewController]
            
            self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        }

    }
}
