//
//  PostViewController.swift
//  MediaMine
//
//  Created by Amy Stockinger on 7/26/19.
//  Copyright © 2019 Amy Stockinger. All rights reserved.
//

// TODO: populate data, image; add back button to company view
// EXTRA: add explanations of data points for user (either on page or separate page with back button)

import Foundation
import UIKit

class PostViewController: UIViewController {
    var postid:String? = ""
    var postData:PostViewData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let postReceived = postid {
            self.postid = postReceived
        }
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
    
    func getImage(){
        let url = URL(string: "http://ec2-3-17-78-5.us-east-2.compute.amazonaws.com/index.php?command=post&postid=" + postid!)
            /////// get image and display in web view
    }
}
