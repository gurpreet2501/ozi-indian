//
//  PlayVideoVC.swift
//  Ozi Indian
//
//  Created by Gurpreet on 21/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit

class PlayVideoVC: UIViewController {

    @IBOutlet weak var lblVideoTitle: UILabel!
    @IBOutlet weak var webViewPlayVideo: UIWebView!

 

    
    //Data received from VideosVC
    var videoTitleReceived:String!
    var videoURLReceived:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(videoTitleReceived)
        print(videoURLReceived)
        print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;")
        
        lblVideoTitle.text = videoTitleReceived
        
        let url = NSURL (string: videoURLReceived)
        let requestVideo = NSURLRequest(URL: url!)
        webViewPlayVideo.loadRequest(requestVideo)
    
      

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

  
    
    

}
