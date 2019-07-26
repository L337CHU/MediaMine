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
    
    @IBOutlet weak var headerText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let stockReceived = ticker {
            self.headerText.text = stockReceived
        }
        
    }
    
}
