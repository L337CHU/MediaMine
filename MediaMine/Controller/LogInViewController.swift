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
        
        guard let email = userEmail.text, let pw = userPassword.text else{
            print("Complete email and pw")
            
            //create alert for user
            
            
            return
        }
        
        
        Auth.auth().signIn(withEmail: userEmail.text!, password: userPassword.text!) { [weak self] user, error in
            guard let strongSelf = self else {
                return
                    
            }
            if error == nil{
                self?.performSegue(withIdentifier: "seeNext", sender: self)
                
            }
            
        }
        
        
        
       
    }
    
    
    
    
    //when optional has value
   // self.performSegue(withIdentifier: "seeNext", sender: self)
    
    
    
    
    
}

