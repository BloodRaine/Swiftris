//
//  ViewController.swift
//  Swiftris
//
//  Created by Robbie Merillat on 11/9/16.
//  Copyright © 2016 Robbie Merillat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var motionView: ScreenMotion!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appDidBecomeActive),
                                       name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appWillResignActive),
                                       name: Notification.Name.UIApplicationWillResignActive, object: nil)
        motionView.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        motionView.animating = true
    }
    
    func appDidBecomeActive(_ notification: Notification)   {
        motionView.animating = true
    }
    
    func appWillResignActive(_ notification: Notification)  {
        motionView.animating = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func howToPlayPressed(_ sender: AnyObject) {
        let alert = UIAlertController (title: "Hey!", message: "This is Tetris for pete's sake, you relly don't know how to play!?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dontTouchThisPressed(_ sender: AnyObject) {
        let alert = UIAlertController (title: "Uh oh!", message: "Now you done messed up!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        motionView.elastic = true;
    }
}
