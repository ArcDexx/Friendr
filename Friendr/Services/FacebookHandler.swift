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
    static func getFacebookData() -> User
    {
        if let accessToken = AccessToken.current
        {
            let params = ["fields" : "name,photos,birthday,friends,likes"]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
            graphRequest.start { (urlResponse, requestResult) in
                switch requestResult {
                case .failed(let error):
                    print(error)
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {
                        UserDefaults.standard.set(responseDictionary, forKey: "userInfo")
                        
                        dump(responseDictionary)
                        
                        //self.ref.child("users").child(user.id).setValue(["name":user.name,"picture": user.picture])
                    }
                }
            }
        }
        
        return User(id: "", name: "", picture: "")
    }
    
    func getUrlFromJSON(json: Any) -> String
    {
        let object = JSON(json)
        return object["data"]["url"].stringValue
    }
}
