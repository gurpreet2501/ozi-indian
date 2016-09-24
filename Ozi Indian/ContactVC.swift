//
//  LiveStreamingVC.swift
//  Ozi Indian
//
//  Created by Gurpreet on 21/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit



class ContactVC: UIViewController {

    var titleReceived:String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = titleReceived
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func menuButtonTapped(sender: UIBarButtonItem) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    
    
 
   
    
    



    
    
    
    
}


    