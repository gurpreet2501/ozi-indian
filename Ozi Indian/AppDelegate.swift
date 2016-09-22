//
//  AppDelegate.swift
//  Ozi Indian
//
//  Created by Gurpreet on 10/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let window = application.windows.first as UIWindow?
        let drawer = window!.rootViewController as! MMDrawerController
        drawer.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        drawer.closeDrawerGestureModeMask = [MMCloseDrawerGestureMode.PanningCenterView, MMCloseDrawerGestureMode.TapCenterView]
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    //    func liveTV(liveURL : String)
    //    {
    //
    //        //            self.mm_drawerController.centerViewController as! UINavigationController
    //        //            self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: nil)
    //        //
    //        //            let alertController = UIAlertController(title: "Live TV", message: "Select the type of video quality you want to play", preferredStyle: .Alert)
    //        //
    //        //            let lowbtn = UIAlertAction(title: "Low Quality", style: UIAlertActionStyle.Default) {
    //        //                UIAlertAction in
    //        //                NSLog("Low Pressed")
    //        //                self.liveTV("http://live.wmncdn.net/oziindian/72781e965e0681e980034a778ee7067b.sdp/mono.m3u8")
    //        //            }
    //        //
    //        //            let highbtn = UIAlertAction(title: "High Quality", style: UIAlertActionStyle.Default) {
    //        //                UIAlertAction in
    //        //                NSLog("High Pressed")
    //        //                self.liveTV("http://live.wmncdn.net/oziindian/bbb19eae240ec100af921d511efc86a0.sdp/mono.m3u8")
    //        //            }
    //        //
    //        //            let cancelbtn = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
    //        //                UIAlertAction in
    //        //                NSLog("Cancel Pressed")
    //        //            }
    //        //
    //        //
    //        //            alertController.addAction(lowbtn)
    //        //            alertController.addAction(highbtn)
    //        //            alertController.addAction(cancelbtn)
    //        //            self.presentViewController(alertController, animated: true, completion: nil)
    //
    //
    //        let videoURL = NSURL(string: liveURL)
    //        let player = AVPlayer(URL: videoURL!)
    //        let playerViewController = AVPlayerViewController()
    //        playerViewController.player = player
    //        self.presentViewController(playerViewController, animated: true) {
    //            playerViewController.player!.play()
    //        }
    //        
    //    }

}

