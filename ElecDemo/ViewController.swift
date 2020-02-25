//
//  ViewController.swift
//  ElecDemo
//
//  Created by NhatHM on 8/9/19.
//  Copyright © 2019 GST.PID. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var console: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        WorkoutTracking.shared.authorizeHealthKit()
        WorkoutTracking.shared.observerHeartRateSamples()
        WatchKitConnection.shared.delegate = self
    }
}

extension ViewController: WatchKitConnectionDelegate {
    func didFinishedActiveSession() {
        WatchKitConnection.shared.sendMessage(message: ["username" : "nhathm" as AnyObject])
    }
    
    func showInConsole(message: [String : Any]) {
        DispatchQueue.main.async {
            self.console.text = self.console.text + "\n\(message.values.first!)"
            let range = NSRange(location: self.console.text.count - 1, length: 1)
            self.console.scrollRangeToVisible(range)
        }
        
    }
}
