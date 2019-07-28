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
        
        // check if fields are empty
        if email.isEmpty || pw.isEmpty{
            self.displayAlert(userMessage:"Please enter a valid email and password.");
            
        }
        
        // sign in
        Auth.auth().signIn(withEmail: userEmail.text!, password: userPassword.text!) { [weak self] user, error in
            guard let strongSelf = self else {
                return
                    
            }
            // if success, go to dashboard
            if error == nil{
                strongSelf.performSegue(withIdentifier: "seeNext", sender: self)
                
            }
            // else, display error
            else{
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .userNotFound:
                        strongSelf.displayAlert(userMessage: "Account not found for the specified user. Please check and try again.")
                    case .userDisabled:
                        strongSelf.displayAlert(userMessage: "Your account has been disabled. Please contact support.")
                    case .invalidEmail, .invalidSender, .invalidRecipientEmail:
                        strongSelf.displayAlert(userMessage: "Please enter a valid email.")
                    case .networkError:
                        strongSelf.displayAlert(userMessage:"Network error. Please try again.")
                    case .wrongPassword:
                        strongSelf.displayAlert(userMessage: "Your password is incorrect. Please try again.")
                    default:
                        strongSelf.displayAlert(userMessage: "Unknown error occurred")
                    }
                }
            }
        }
    }

    //when optional has value
   // self.performSegue(withIdentifier: "seeNext", sender: self)
    
    
}

