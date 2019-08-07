//
//  PostViewController.swift
//  MediaMine
//
//  Created by Amy Stockinger on 7/26/19.
//  Copyright © 2019 Amy Stockinger. All rights reserved.
//

// TODO: populate data, scale image
// EXTRA: add explanations of data points for user (either on page or separate page with back button)

import Foundation
import UIKit
import WebKit

class PostViewController: UIViewController {
    var postid:String? = ""
    var ticker:String? = ""
    var postData:PostViewData? = nil
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var goBackBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let postReceived = postid {
            self.postid = postReceived
        }
        if let stockReceived = ticker {
            self.ticker = stockReceived
        }
        
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
