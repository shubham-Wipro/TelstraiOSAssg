//
//  ViewController.swift
//  TelstraPOC
//
//  Created by Shubh on 09/02/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    var tableView: UITableView!
    let cellIdentifier = "cell"
    var refreshView: UIRefreshControl!
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
    }
    
    func addTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        refreshView = UIRefreshControl()
        refreshView.attributedTitle = NSAttributedString(string: "Swipe to Refresh")
        refreshView.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        self.view.addSubview(tableView)
        self.tableView.addSubview(refreshView)
        
        //Add activity Indicator
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.red
        activityIndicator.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        //TODO: To be Stop when data is loaded
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //Setting TableView Constraints
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
    
    func reloadDataInTable(){
        
    }
    
    @objc func refreshTableView(){
        reloadDataInTable()
    }
    
    
//MARK: TableView Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? DataTableViewCell
                  cell?.accessibilityIdentifier = "cell"
                  if cell == nil{
                      cell = DataTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
                  }
                  return cell!
       }
}

