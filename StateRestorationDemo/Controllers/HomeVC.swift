//
//  HomeVC.swift
//  StateRestorationDemo
//
//  Created by Yudiz Solutions on 16/03/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
//    let names = ["Shah Rukh Khan", "Salman Khan", "Akshay Kumar", "Kevin Shah", "Hrithik Roshan", "Aamir Khan", "Ranbir Kapoor", "Amitabh Bachchan", "Varun Dhawan", "Ranveer Singh", "Ajay Devgan", "Saif Ali Khan", "Anil Kapoor", "John Abraham", "Arjun Rampal", "Sidharth Malhotra"]
    let names = ["Ranbir Kapoor", "Bradley Cooper", "Johnny Depp", "Angelina Jolie", "Ben Stiller", "Vin Diesel", "Katrina Kaif", "Shah Rukh Khan", "Robert Downey", "Emraan Hashmi", "Mark Wahlberg", "Drew Barrymore", "Ranveer-Singh", "John Abraham", "Salman Khan", "Tom Cruise"]

    var arrUsers: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        self.restorationIdentifier = "HomeVC"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- UI Methods
extension HomeVC{
    
    func prepareUI(){
        self.tableView.rowHeight = 55
        
        prepareData()
    }
    func prepareData(){
        if arrUsers.isEmpty{
            for (idx, name) in names.enumerated() {
                arrUsers.append(User(name, imgN: "\(idx+1)"))
            }
        }
       
        
    }
}

//  MARK:- UITableView Data Source & Delegate
extension HomeVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeCell
        cell.prepareToFillUserData(arrUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeDetailVC") as! HomeDetailVC
        vc.objUser = arrUsers[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//  MARK:- UIViewControllerRestoration
extension HomeVC{
  
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        // preserve all user model object.
        coder.encode(self.arrUsers, forKey: "arrUsers")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        if let arr = coder.decodeObject(forKey: "arrUsers") as? [User]{
            self.arrUsers = arr
        }
    }
    override func applicationFinishedRestoringState() {
        print("HomeVC finished restoring")
        self.tableView.reloadData()
    }
}
