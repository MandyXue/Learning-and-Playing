//
//  BookTableViewController.swift
//  TableViewIndex
//
//  Created by MandyXue on 15/11/13.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var book = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        book.groupBook()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source

    //section number
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return book.headers.count
    }
    
    //section title
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return book.headers[section]
    }
    //section cell number
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.groupedBooks[section].count
    }
    
    //index title
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return book.headers
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "BookCellIdentifier"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        cell.textLabel?.text = book.groupedBooks[indexPath.section][indexPath.item]
        return cell
    }
    
    
    
}
