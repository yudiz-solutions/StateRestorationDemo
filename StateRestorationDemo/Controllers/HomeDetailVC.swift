//
//  HomeDetailVC.swift
//  StateRestorationDemo
//
//  Created by Yudiz Solutions on 16/03/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import UIKit

class HomeDetailVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    var objUser: User!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK:- UI Methods
extension HomeDetailVC{
    
    func prepareUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 250
        
        if let obj = objUser{
            self.title =  obj.name
        }else{
            self.title = "Unknown"
        }
    }
    
}
//  MARK:- UITableView Data Source & Delegate
extension HomeDetailVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = objUser{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeCell
        cell.prepareToFillUserData(objUser, isFullDetail: true)
        return cell
    }
    
    
}

//  MARK:- UIViewControllerRestoration
extension HomeDetailVC: UIViewControllerRestoration{
    static func viewController(withRestorationIdentifierPath identifierComponents: [Any], coder: NSCoder) -> UIViewController? {
        guard let restoredUser = coder.decodeObject(forKey: "objUser") as? User else {
            print("decoding User Detail")
            return nil
        }
        if let storyboard = coder.decodeObject(forKey: UIStateRestorationViewControllerStoryboardKey) as? UIStoryboard{
            if let vc = storyboard.instantiateViewController(withIdentifier: "HomeDetailVC") as? HomeDetailVC{
                vc.objUser = restoredUser
                return vc;
            }
        }
        return nil;
    }
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        // preserve user model object.
        coder.encode(self.objUser, forKey: "objUser")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        if let obj = coder.decodeObject(forKey: "objUser") as? User{
            self.objUser = obj
        }
    }
    
    override func applicationFinishedRestoringState() {
        print("HomeDetailVC finished restoring")
        self.prepareUI()
        self.tableView.reloadData()

    }
}



