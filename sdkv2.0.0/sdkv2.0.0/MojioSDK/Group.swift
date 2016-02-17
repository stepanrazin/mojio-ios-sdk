//
//  Group.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Group: Object, Mappable {
    dynamic var Name : String? = nil
    dynamic var Description : String? = nil
    var Users = List<User>()
    var Tags = List<StringObject>()
    dynamic var Id : String? = nil
    dynamic var CreatedOn : String? = nil
    dynamic var LastModified : String? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        var users = Array<User>()
        users <- map["Users"]
        
        for user in users {
            self.Users.append(user)
        }
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }

        
        Name <- map["Name"];
        Description <- map["Description"];
//        Users <- map["Users"];
//        Tags <- map["Tags"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }

}
