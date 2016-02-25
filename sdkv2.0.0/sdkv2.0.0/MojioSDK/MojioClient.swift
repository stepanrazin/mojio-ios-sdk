//
//  MojioClient.swift
//  MOJIOSDK
//
//  Created by Ashish Agarwal on 2016-02-08.
//  Copyright © 2016 Ashish. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import RealmSwift
import KeychainSwift

class MojioClient: NSObject {
    
    static let client = MojioClient()
    
    private var REQUEST_URL : String
    private var REST_METHOD : Alamofire.Method?
    
    
    private let PATH_APPS : String = "apps/"
    private let PATH_SECRET : String = "secret/"
    private let PATH_GROUPS : String = "groups/"
    private let PATH_USERS : String = "users/"
    private let PATH_ME : String = "me/"
    private let PATH_HISTORY : String = "history/"
    private let PATH_STATES : String = "states/"
    private let PATH_LOCATIONS : String = "locations/"
    private let PATH_IMAGE : String = "image/"
    private let PATH_MOJIOS : String = "mojios/"
    private let PATH_PERMISSION : String = "permission/"
    private let PATH_PERMISSIONS : String = "permissions/"
    private let PATH_TAGS : String = "tags/"
    private let PATH_TRIPS : String = "trips/"
    private let PATH_VEHICLES : String = "vehicles/"
    private let PATH_ADDRESS : String = "address/"
    private let PATH_VIN : String = "vin/"
    private let PATH_SERVICE_SCHEDULE = "serviceschedule/"
    private let PATH_NEXT : String = "next/"
    
    override init () {
        self.REQUEST_URL = MojioClientEnvironment.clientEnvironment.apiEndpoint()
        // set auth token as the header 
    }
    
    func get () {
        self.REST_METHOD = Method.GET
    }
    
    func post () {
        self.REST_METHOD = Method.POST
    }
    
    func put () {
        self.REST_METHOD = Method.PUT
    }
    
    func delete () {
        self.REST_METHOD = Method.DELETE
    }
    
    func apps (appId : String?) -> Self {
        if appId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_APPS + appId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_APPS
        }
        return self
    }
    
    func secret () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_SECRET
        return self
    }
    
    func groups (groupId : String?) -> Self {
        if (groupId != nil) {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_GROUPS + groupId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_GROUPS
        }
        return self
    }
    
    func users (userId : String?) -> Self {
        if userId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_USERS + userId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_USERS
        }
        return self
    }
    
    func me () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_ME
        return self
    }
    
    func history () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_HISTORY
        return self
    }
    
    func states () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_STATES
        return self
    }
    
    func locations () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_LOCATIONS
        return self
    }
    
    func image () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_IMAGE
        return self
    }
    
    func mojios (mojioId : String?) -> Self {
        if mojioId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_MOJIOS + mojioId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_MOJIOS
        }
        return self
    }
    
    func permission () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_PERMISSION
        return self
    }
    
    func permissions () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_PERMISSIONS
        return self
    }
    
    func tags (tagId : String) -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_TAGS + tagId + "/"
        return self
    }
    
    func trips (tripId : String?) -> Self {
        if tripId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_TRIPS + tripId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_TRIPS
        }
        return self
    }
    
    func vehicles (vehicleId : String?) -> Self {
        if vehicleId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_VEHICLES + vehicleId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_VEHICLES
        }
        return self
    }
    
    func address () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_ADDRESS
        return self
    }
    
    func vin () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_VIN
        return self
    }
    
    func serviceschedule () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_SERVICE_SCHEDULE
        return self
    }
    
    func next () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_NEXT
        return self
    }
    
    func run (completion : (response : AnyObject) -> Void, failure : (error : String) -> Void){
        let authToken = self.authToken()!;
        
        Alamofire.request(REST_METHOD!, self.REQUEST_URL, headers : ["MojioAPIToken" : authToken]).responseJSON { response in
            let dict : NSDictionary? = response.result.value as? NSDictionary
            let json : JSON = JSON(response.result.value ?? [])
            print (dict)
        }
        
    }
    
    
    private func authToken () -> String? {
        let keychain = KeychainSwift()
        let authToken : String? = keychain.get("MojioAuthToken")
        return authToken
    }
    
    func createObserver () {
        var observer : Observer = Observer()
        observer.Key = "Ashish Key"
        observer.Name = "First Vehicle Observer"
        var transport : Transport = Transport(clientId: "9692e2af-07f6-46ed-b384-1831b739ebf6", hubName: "VehicleHub", callback: nil)
        
        observer.Transports = transport
        var str = observer.toString()
        let json = JSONSerializer.toJson(observer)
        
        
        let url : String = "https://staging-push.moj.io/v2/vehicles/eff1ccd0-e718-4e28-a985-945a2994f689"
//        let authToken = self.authToken()!;

        
        Alamofire.request(Method.GET, url, parameters: [:], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
//            mutableRequest.setValue(authToken, forHTTPHeaderField : "MojioAPIToken")
            mutableRequest.HTTPBody = str.dataUsingEncoding(NSUTF8StringEncoding)
            return (mutableRequest, nil)
        })).responseJSON{ response in
            
            if response.response?.statusCode != 200 {
                print ("failed to create observer")
            }
            else {
                let json : JSON = JSON(response.result.value ?? [])
                if json != nil {
                    print (json)
                }
                else {
                }
            }
            
        }

    }
}