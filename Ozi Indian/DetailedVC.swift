//
//  ContactVC.swift
//  Ozi Indian
//
//  Created by Gurpreet on 13/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func menuTapped(sender: UIBarButtonItem) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }




}
