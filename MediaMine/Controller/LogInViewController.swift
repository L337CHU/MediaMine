//
//  LogInViewController.swift
//  MediaMine
//
//  Created by Christopher Chu on 7/12/19.
//  Copyright © 2019 Christopher Chu. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {

        Auth.auth().signIn(withEmail: userEmail.text!, password: userPassword.text!) { [weak self] user, error in
            guard
                let strongSelf = self
                else { return }
            // ...
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}

