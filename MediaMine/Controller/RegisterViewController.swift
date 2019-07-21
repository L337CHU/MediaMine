//
//  RegisterViewController.swift
//  MediaMine
//
//  Created by Christopher Chu on 7/16/19.
//  Copyright © 2019 Christopher Chu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var verifyPassword: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var termsAndAgreement: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - REGISTRATION
    @IBAction func regSubmission(_ sender: Any) {
        //print(userName.text!)
        
        //register new user to database
        let emailText = userEmail.text!
        let passwordText = userPassword.text!
        
        //print(emailText)
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { authResult, error in
            
            //registration credentials are valid, so signin user
            if error == nil{
                //check to see if user agrees to terms and conditions
                
        
                
                Auth.auth().signIn(withEmail: self.userEmail.text!, password: self.userPassword.text!)
                
                //go to next segue
                self.performSegue(withIdentifier: "seeNext", sender: self)
                
            }
            else{
                print(error!)
                
                //alert user what the error is
                
            }
        }
 
        
        
    }
    
    
    
    
    
    

}
