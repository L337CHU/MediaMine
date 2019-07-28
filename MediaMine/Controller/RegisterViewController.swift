//
//  RegisterViewController.swift
//  MediaMine
//
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var verifyPassword: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var termsAndAgreement: UISwitch!
    var agreed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkTerms(_ sender: UISwitch) {
        if(sender.isOn == true){
            agreed = true;
        }
        else{
            agreed = false;
        }
    }
    
    func displayAlert(userMessage:String){
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:nil);
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion: nil);
    }
    
    // MARK: - REGISTRATION
    @IBAction func regSubmission(_ sender: Any) {
        //print(userName.text!)
        
        //register new user to database
        let emailText = userEmail.text!
        let passwordText = userPassword.text!
        let passwordVerifyText = verifyPassword.text!
        
        // check fields are completed
        if((emailText.isEmpty) || (passwordText.isEmpty) || (passwordVerifyText.isEmpty)){
            displayAlert(userMessage: "All fields are required");
            return;
        }
        
        // check passwords, they must match
        if(passwordText != passwordVerifyText){
            displayAlert(userMessage: "Passwords do not match");
            return;
        }
        
        // validate email and password
        let validator = Validation()
        
        let validEmail = validator.validate(values: (type: ValidationType.email, inputValue: emailText));
        switch validEmail{
        case .success:
            break
        case .failure(_, let message):
            displayAlert(userMessage: message.rawValue)
            return;
        }
        
        let validPassword = validator.validate(values: (type: ValidationType.password, inputValue: passwordText));
        switch validPassword{
        case .success:
            break
        case .failure(_, let message):
            displayAlert(userMessage: message.rawValue)
            return;
        }
        
        // check terms agreement
        if(termsAndAgreement != nil){
            checkTerms(termsAndAgreement);
        }
        if(agreed == false){
            displayAlert(userMessage: "Please read the Terms and Conditions");
            return;
        }
        
        // check for error in making account
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { authResult, error in
            
            //registration credentials are valid, so signin user
            if error == nil{
                Auth.auth().signIn(withEmail: self.userEmail.text!, password: self.userPassword.text!)
                
                //go to next segue
                self.performSegue(withIdentifier: "seeNext", sender: self)
                
            }
            // else, error
            else{
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .emailAlreadyInUse:
                        self.displayAlert(userMessage: "The email is already in use with another account.")
                    case .userNotFound:
                        self.displayAlert(userMessage: "Account not found for the specified user. Please check and try again")
                    case .userDisabled:
                        self.displayAlert(userMessage: "Your account has been disabled. Please contact support.")
                    case .invalidEmail, .invalidSender, .invalidRecipientEmail:
                        self.displayAlert(userMessage: "Please enter a valid email")
                    case .networkError:
                        self.displayAlert(userMessage:"Network error. Please try again.")
                    case .weakPassword:
                        self.displayAlert(userMessage: "Your password is too weak. The password must be 6 characters long or more.")
                    default:
                        self.displayAlert(userMessage: "Unknown error occurred")
                    }
                }
            }
        }
    }
}
