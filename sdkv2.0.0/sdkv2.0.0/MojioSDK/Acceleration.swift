//
//  Acceleration.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Acceleration: Object, Mappable {

    dynamic var BaseUnit : NSString? = nil //['MetersPerSecondPerSecond', 'KilometersPerHourPerSecond', 'MilesPerHourPerSecond'],
    dynamic var Timestamp : NSString? = nil
    var BaseValue = RealmOptional<Double>()
    dynamic var Unit : NSString? = nil  //['MetersPerSecondPerSecond', 'KilometersPerHourPerSecond', 'MilesPerHourPerSecond'],
    var Value = RealmOptional<Double>()

    required convenience init?(_ map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
