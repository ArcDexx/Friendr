//
//  FacebookHandler.swift
//  Friendr
//
//  Created by Dalila Watts on 24/12/2016.
//  Copyright © 2016 epita. All rights reserved.
//

import Foundation
import FacebookCore
import SwiftyJSON
import FirebaseDatabase
class FacebookHandler
{
    static var ref: FIRDatabaseReference!
    
    static func getFacebookData(lat: Double, long: Double)
    {
        if AccessToken.current != nil
        {
            let params = ["fields" : "name,picture,birthday,friends,likes"]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
            graphRequest.start { (urlResponse, requestResult) in
                switch requestResult {
                case .failed(let error):
                    print(error)
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue
                    {
                        handleFacebookResult(response: responseDictionary, lat: lat, long: long)
                    }
                }
            }
        }
    }
    
    static func handleFacebookResult(response: [String : Any], lat: Double, long: Double)
    {
        ref = FIRDatabase.database().reference()
        
        let id = AccessToken.current?.userId
        let birthday = response["birthday"]
        let name = response["name"]
        
        
        let friendObject = JSON(response["friends"]!)
        let friends = friendObject["summary"]["total_count"]
        
        let pictureObject = JSON(response["picture"]!)
        let picture = pictureObject["data"]["url"]
        
        self.ref.child("users").child(id!).setValue(["name":name,
                                                     "picture":picture.stringValue,
                                                     "id":id,
                                                     "birthday":birthday,
                                                     "friends_count":friends.stringValue,
                                                     "latitude":lat,
                                                     "longitude":long])
    }
    
    func getUrlFromJSON(json: Any) -> String
    {
        let object = JSON(json)
        return object["data"]["url"].stringValue
    }
}
