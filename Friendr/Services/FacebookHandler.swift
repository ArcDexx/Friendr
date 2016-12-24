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
    static func getFacebookData()
    {
        if let accessToken = AccessToken.current
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
                        handleFacebookResult(response: responseDictionary)
                        
                        //self.ref.child("users").child(user.id).setValue(["name":user.name,"picture": user.picture])
                    }
                }
            }
        }
    }
    
    static func handleFacebookResult(response: [String : Any])
    {
        let id = AccessToken.current?.userId
        let birthday = response["birthday"]
        let name = response["name"]
        
        let friendObject = JSON(response["friends"]!)
        let friends = friendObject["summary"]["total_count"]
        
        print(id!)
        print(birthday!)
        print(name!)
        print(friends)
    }

    func getUrlFromJSON(json: Any) -> String
    {
        let object = JSON(json)
        return object["data"]["url"].stringValue
    }
}
