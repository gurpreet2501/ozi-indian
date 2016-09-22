//
//  LiveStreamingVC.swift
//  Ozi Indian
//
//  Created by Gurpreet on 21/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class LiveStreamingVC: UIViewController {

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
    
    
    
    @IBAction func btnHighTapped(sender: UIButton) {

                liveTV("http://live.wmncdn.net/oziindian/bbb19eae240ec100af921d511efc86a0.sdp/mono.m3u8")
        
    }//btnHighTapped

    
    @IBAction func btnLowTapped(sender: UIButton) {
        
                liveTV("http://live.wmncdn.net/oziindian/72781e965e0681e980034a778ee7067b.sdp/mono.m3u8")
    }
    
    
    func liveTV(liveURL : String)
    {
        let videoURL = NSURL(string: liveURL)
        let player = AVPlayer(URL: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player!.play()
        }

    }
    
    
    
    
}


    