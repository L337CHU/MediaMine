//
//  LogInViewController.swift
//  MediaMine
//
//  Created by Christopher Chu on 7/12/19.
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
    
    func displayAlert(userMessage:String){
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:nil);
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion: nil);
    }
    

    @IBAction func buttonPressed(_ sender: Any) {

        guard let email = userEmail.text, let pw = userPassword.text else{
            
            return
        }
        
        if email.isEmpty || pw.isEmpty{
            self.displayAlert(userMessage:"Please enter a valid email and password.");
            
        }
        
        
        Auth.auth().signIn(withEmail: userEmail.text!, password: userPassword.text!) { [weak self] user, error in
            guard let strongSelf = self else {
                return
                    
            }
            if error == nil{
                self?.performSegue(withIdentifier: "seeNext", sender: self)
                
            }
            else{
                self?.displayAlert(userMessage:"That email and password combination does not exist.");
            }
        }
    }
    
    
    
    
    //when optional has value
   // self.performSegue(withIdentifier: "seeNext", sender: self)
    
    
}

