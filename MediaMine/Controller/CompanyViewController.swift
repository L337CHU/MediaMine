//
//  CompanyViewController.swift
//  MediaMine
//
//  Created by Amy Stockinger on 7/25/19.
//  Copyright © 2019 Amy Stockinger. All rights reserved.
//

import Foundation
import UIKit

class CompanyViewController: UIViewController {
    
    var ticker:String? = ""
    let userProfileData = UserDefaults.standard
    
    @IBOutlet weak var headerText: UITextView!
    @IBOutlet weak var addStockBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let stockReceived = ticker {
            self.headerText.text = stockReceived
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // add a company button controls if user is able to add to their dashboard list
    @IBAction func addStockClicked(_ sender: Any) {
        if temp.contains(ticker!) {
            displayAlert(userMessage: "You have already added this stock.")
            return
        }
        else if temp.count > 7 {
            displayAlert(userMessage: "You are already watching 8 stocks.")
            return
        }
        else{
            temp.append(ticker!)
            userProfileData.set(temp, forKey: "ProfileArray")
            displayAlert(userMessage: "Stock successfully added!")
        }
    }
    
    func displayAlert(userMessage:String) {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:nil);
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion: nil);
    }
}
