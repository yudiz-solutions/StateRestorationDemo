//
//  User.swift
//  StateRestorationDemo
//
//  Created by Yudiz Solutions on 16/03/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String
    var email: String
    var imgName: String
    var desc: String
    
    override init() {
        name = ""
        email = ""
        imgName = ""
        desc = ""
        super.init()
    }

    init(_ strName: String, imgN: String) {
        name = strName
        let str =  name.replacingOccurrences(of: " ", with: "").lowercased()
        email = "\(str)@gmail.com"
        imgName = imgN
        desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        super.init()
    }
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        if let decode = aDecoder.decodeObject(forKey: "name") as? String {
            name = decode
        }
        
        if let decode = aDecoder.decodeObject(forKey: "email") as? String {
            email = decode
        }
        
        if let decode = aDecoder.decodeObject(forKey: "imgName") as? String {
            imgName = decode
        }
        if let decode = aDecoder.decodeObject(forKey: "desc") as? String {
            desc = decode
        }
    }
}

extension User: NSCoding {
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(imgName, forKey: "imgName")
        aCoder.encode(desc, forKey: "desc")
    }
    
 
}
