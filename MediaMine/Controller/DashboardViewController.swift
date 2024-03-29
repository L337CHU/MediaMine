//
//  DashboardViewController.swift
//  MediaMine
//
//  Created by Amy Stockinger on 7/25/19.
//  Copyright © 2019 Amy Stockinger. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var welcomeText: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load the saved profile data
        if let dataList = userProfileData.array(forKey: "ProfileArray") as? [String]{
            temp = dataList.sorted(by: { $0 < $1 })
        }
        
        // get user's email and display greeting
        let user = Auth.auth().currentUser?.email;
        self.welcomeText.text = "Welcome, " + user!;
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stockcell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // get number of stored companies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    // display user's companies
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockcell", for: indexPath);
        let celltext = temp[indexPath.row]
        cell.textLabel?.text = celltext
        return cell;
    }
    
    // allow user to remove company from dashboard view by swipping and deleting
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCell.EditingStyle.delete{
            temp.remove(at: indexPath.row)
            userProfileData.set(temp, forKey: "ProfileArray")
            tableView.reloadData()
        }
    }
    
    // allow user to click a company to go to the company view page
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = temp[indexPath.row]
        self.performSegue(withIdentifier: "selectStock", sender: text)
    }
    // pass company ticker to company view page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectStock" {
            let controller = segue.destination as! CompanyViewController
            let textPass = sender as! String
            controller.ticker = textPass
        }
    }
    
}
