//
//  DetailVC.swift
//  Ozi Indian
//
//  Created by Gurpreet on 19/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var imgViewNews: UIImageView!
    @IBOutlet weak var lblTitleNews: UILabel!
    @IBOutlet weak var lblDetailNews: UILabel!
    
    //Data received from HomeVC
    var newsTitleReceived:String!
    var newsImageReceived:String!
    var newsDescriptionReceived:String!
    var newsIdReceived:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("************************")
        print(newsTitleReceived)
        print("************************")
        print(newsImageReceived)
        print("************************")
        print(newsDescriptionReceived)
        print("************************")
        print(newsIdReceived)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action , target: self, action: "displayShareSheet")
        
        lblTitleNews.text = newsTitleReceived
        
        let url = NSURL(string: newsImageReceived)
        imgViewNews.sd_setImageWithURL(url)
        
        lblDetailNews.text = newsDescriptionReceived
        
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func displayShareSheet() {
        let activityViewController = UIActivityViewController(activityItems: [newsTitleReceived , "http://m.oziindian.tv/detailnews.php?code=\(newsIdReceived)"], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: {})
    }

}
