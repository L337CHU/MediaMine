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
        
        let user = Auth.auth().currentUser?.email;
        self.welcomeText.text = "Welcome, " + user!;
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stockcell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    ///////// get user stocks from db...
    var temp = ["AAPL", "GOOG", "TSLA"] // temp data
    ///////////////////////////////////
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockcell", for: indexPath);
        let celltext = self.temp[indexPath.row]
        cell.textLabel?.text = celltext
        return cell;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCell.EditingStyle.delete{
            temp.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = self.temp[indexPath.row]
        self.performSegue(withIdentifier: "selectStock", sender: text)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectStock" {
            let controller = segue.destination as! CompanyViewController
            let textPass = sender as! String
            controller.ticker = textPass
        }
    }
    
}
