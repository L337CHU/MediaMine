//
//  SearchViewController.swift
//  MediaMine
//
//  Created by Amy Stockinger on 7/25/19.
//  Copyright © 2019 Amy Stockinger. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //saving profile data
    let userProfileData = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    //////////////////////////////////////////
    // populate table view with stock tickers
    //////////////////////////////////////////
   
    //var stocks = ["AAPL", "GOOG", "TSLA"]
    
    var search = [String]()
    var searching = false
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int{
        if searching == true {
            return search.count
        }
        /////// change to num stock tickers
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text: String!
        if searching {
            text = search[indexPath.row]
        }
        else{
            text = stocks[indexPath.row]
        }
        cell.textLabel!.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text:String!
        if searching{
            text = self.search[indexPath.row]
        }
        else{
           // text = self.stocks[indexPath.row]
            text = stocks[indexPath.row]

        }
        temp.append(text)
        userProfileData.set(temp, forKey: "ProfileArray")
        self.performSegue(withIdentifier: "selectCompany", sender: text)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCompany" {
            let controller = segue.destination as! CompanyViewController
            let textPass = sender as! String
            controller.ticker = textPass
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ seachBar: UISearchBar, textDidChange searchText: String){
        search = stocks.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
