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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    var search = [String]()         // contains user entered query
    var searching = false           // bool if search is active
    let stocksSorted = stocks.sorted(by: { $0 < $1 })
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    // adjust table cell count display if user is searching or not
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int{
        if searching == true {
            return search.count
        }
        return stocksSorted.count
    }
    
    // display cells according to user query
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text: String!
        if searching {
            text = search[indexPath.row]
        }
        else{
            text = stocksSorted[indexPath.row]
        }
        cell.textLabel!.text = text
        return cell
    }
    
    // go to company view page if user clicks a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text:String!
        if searching{
            text = self.search[indexPath.row]
        }
        else{
            text = stocksSorted[indexPath.row]

        }
        self.performSegue(withIdentifier: "selectCompany", sender: text)
    }
    // send company ticker along with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCompany" {
            let controller = segue.destination as! CompanyViewController
            let textPass = sender as! String
            controller.ticker = textPass
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    // filter search table display according to search
    func searchBar(_ seachBar: UISearchBar, textDidChange searchText: String){
        search = stocksSorted.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    // handle cancel button removing text from search bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
