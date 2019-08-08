//
//  PostViewController.swift
//  MediaMine
//
//  Created by Amy Stockinger on 7/26/19.
//  Copyright © 2019 Amy Stockinger. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class PostViewController: UIViewController {
    var postid:String? = ""
    var ticker:String? = ""
    var postData:PostViewData? = nil
    var values:[String?] = ["", "", "", "", "", "", "", ""]
    let property = ["Polarity", "Sentiment Analysis", "Pronoun Count", "Noun Count", "Verb Count", "Adjective Count", "Adverb Count", "Total Words"]
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var goBackBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let postReceived = postid {
            self.postid = postReceived
        }
        if let stockReceived = ticker {
            self.ticker = stockReceived
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        goBackBtn.setTitle("Go back to " + ticker!, for: .normal)
        
        getImage()
        parseJSON()
    }
    
    // get data points
    func parseJSON() {
        let url = URL(string: "http://ec2-3-17-78-5.us-east-2.compute.amazonaws.com/index.php?command=data&postid=" + postid!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                self.postData = try JSONDecoder().decode(PostViewData.self, from: data!)
                self.values = [self.postData?.polarity, self.postData?.afinn_sentiment, self.postData?.pronoun_fraction, self.postData?.noun_fraction, self.postData?.verb_fraction, self.postData?.adjective_fraction, self.postData?.adjective_fraction, self.postData?.total_words]
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
    
    // load image from API
    func getImage(){
        let url = URL(string: "http://ec2-3-17-78-5.us-east-2.compute.amazonaws.com/index.php?command=post&postid=" + postid!)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    // go back to proper company view upon clicking back button
    @IBAction func clickBackBtn(_ sender: Any) {
        performSegue(withIdentifier: "goBack", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBack" {
            let controller = segue.destination as! CompanyViewController
            controller.ticker = ticker!
        }
    }
}

extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    // display API data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = property[indexPath.row] + "\t\t" + values[indexPath.row]!
        return cell
    }
}
