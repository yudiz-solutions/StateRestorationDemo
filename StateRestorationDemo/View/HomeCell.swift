//
//  HomeCell.swift
//  StateRestorationDemo
//
//  Created by Yudiz Solutions on 16/03/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import Foundation
import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    @IBOutlet var imgv: UIImageView!
    
    func prepareToFillUserData(_ objUser: User, isFullDetail: Bool = false){
        if isFullDetail{
            self.lblTitle.text = objUser.email
            self.lblSubtitle.text = objUser.desc
            self.imgv.image = UIImage(named: objUser.imgName)
        }else{
            self.lblTitle.text = objUser.name
        }
    }
   
}
