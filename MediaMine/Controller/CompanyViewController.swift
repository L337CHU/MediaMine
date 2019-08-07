//
//  CompanyViewController.swift
//  MediaMine
//
//  Created by Amy Stockinger on 7/25/19.
//  Copyright © 2019 Amy Stockinger. All rights reserved.
//
// EXTRA: display company name along with ticker at the top

import Foundation
import UIKit

class CompanyViewController: UIViewController {
    
    var ticker:String? = ""
    let userProfileData = UserDefaults.standard
    var prices:[CompanyViewRow] = []
    
    @IBOutlet weak var headerText: UITextView!
    @IBOutlet weak var addStockBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let stockReceived = ticker {
            self.headerText.text = stockReceived
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        parseJSON()
    }
    
    // populate table with API data
    func parseJSON() {
        let url = URL(string: "http://ec2-3-17-78-5.us-east-2.compute.amazonaws.com/index.php?command=price&company=" + ticker!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                self.prices = try JSONDecoder().decode([CompanyViewRow].self, from: data!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                print("Error is : \n\(error)")
            }
        }
        task.resume()
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

extension CompanyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prices.count
    }
    
    // display API data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dataPt = self.prices[indexPath.row]
        cell.textLabel!.text = String(dataPt.created_time + "     " + dataPt.predicted_impressions_count + "       " +  dataPt.price)
        return cell
    }
    
    // go to post view page if user clicks a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var text:[String] = []
        text.append(prices[indexPath.row].id)
        text.append(self.ticker!)
        self.performSegue(withIdentifier: "selectPost", sender: text)
    }
    // send post id with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectPost" {
            let controller = segue.destination as! PostViewController
            let textPass = sender as! [String]
            controller.postid = textPass[0]
            controller.ticker = textPass[1]
        }
    }
}
