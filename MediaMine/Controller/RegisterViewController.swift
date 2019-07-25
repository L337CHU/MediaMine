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
    
    // MARK: - REGISTRATION
    @IBAction func regSubmission(_ sender: Any) {
        //print(userName.text!)
        
        //register new user to database
        let emailText = userEmail.text!
        let passwordText = userPassword.text!
        let passwordVerifyText = verifyPassword.text!
        
        // check fields
        if((emailText.isEmpty) || (passwordText.isEmpty) || (passwordVerifyText.isEmpty)){
            // display alert message
            displayAlert(userMessage: "All fields are required");
            return;
        }
        
        // check passwords, they must match
        if(passwordText != passwordVerifyText){
            // display alert message
            displayAlert(userMessage: "Passwords do not match");
            return;
        }
        
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
        
        // check term agreement
        if(termsAndAgreement != nil){
            checkTerms(termsAndAgreement);
        }
        if(agreed == false){
            displayAlert(userMessage: "Please read the Terms and Conditions");
            return;
        }
        
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
    
    func displayAlert(userMessage:String){
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:nil);
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion: nil);
    }
}
