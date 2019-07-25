//
//  DashboardViewController.swift
//  MediaMine
//
//  Created by Amy Stockinger on 7/25/19.
//  Copyright © 2019 Amy Stockinger All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DashoardViewController: UIViewController {
    
    @IBOutlet weak var welcomeText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser?.email;
        self.welcomeText.text = "Welcome, " + user!;
    }
    
}
