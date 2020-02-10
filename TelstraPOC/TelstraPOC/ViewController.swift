//
//  ViewController.swift
//  TelstraPOC
//
//  Created by Shubh on 09/02/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit
import Reachability

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var tableView: UITableView!
    let cellIdentifier = "cell"
    var refreshView: UIRefreshControl!
    var activityIndicator: UIActivityIndicatorView!
    var apiCalls: CallAPI!
    var rowsArray: [dataRows] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        apiCalls = CallAPI()
        apiCalls.delegate = self
        updateTableViewData()
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
    
    func reloadDataInTable(data: jsonModel){
        DispatchQueue.main.async {
            weak var weakself = self
            weakself?.navigationItem.title = data.title ?? ""
            weakself?.rowsArray = data.rows
            if weakself?.rowsArray.count == 0{
                weakself?.showAlert(title: "No Data Available", description: "Check Internet connection")
            }else{
                weakself?.tableView.reloadData()
            }
            weakself?.activityIndicator.stopAnimating()
            weakself?.refreshView.endRefreshing()
        }
    }
    
    @objc func refreshTableView(){
        updateTableViewData()
    }
    
    func updateTableViewData(){
        if checkConectivity(){
            activityIndicator.startAnimating()
            apiCalls.dataRequest(fetchingUrl: Constants.default_URL)
        }else{
            DispatchQueue.main.async {
                weak var weakself = self
                weakself?.activityIndicator.stopAnimating()
                weakself?.showAlert(title: "Error", description: "Check Internet connection")
            }
        }
    }
    
//MARK: TableView Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsArray.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? DataTableViewCell
        cell?.accessibilityIdentifier = "cell"
        if cell == nil{
            cell = DataTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        let itemData = rowsArray[indexPath.row]
        cell?.updateTableViewData(rowItems: itemData)
        return cell!
    }
//MARK: Alert
    func showAlert(title: String, description: String){
        let alertPopUp = UIAlertController(title: title, message: description, preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Close", style: .default) { (action) in
                if self.refreshView.isRefreshing == true{
                    self.refreshView.endRefreshing()
                }
            }
        
        alertPopUp.addAction(alertButton)
        self.present(alertPopUp, animated: true, completion: nil)
        }
}

extension ViewController{
    func checkConectivity() -> Bool{
        do{
            let reachability = try Reachability()
            if reachability.connection != .unavailable{
                return true
            }else{
                return false
            }
        }catch{
            return error as! Bool
        }
    }
}

extension ViewController: CallApiDelegate{
    func didReceiveResponse(data: jsonModel?, code: Int?, error: Error?) {
        if error == nil{
            if let data = data{
                reloadDataInTable(data: data)
            }
        }else{
            DispatchQueue.main.async {
                weak var weakSelf = self
                weakSelf?.activityIndicator.stopAnimating()
                weakSelf?.showAlert(title: "API Error", description: error?.localizedDescription ?? "")
            }
        }
    }
}
