//
//  User.swift
//  Friendr
//
//  Created by Dalila Watts on 24/12/2016.
//  Copyright © 2016 epita. All rights reserved.
//

import Foundation

class User
{
    var id: String
    var name: String
    var picture: String
    var birthday: String
    var age : String
    var sampleLikes: String
    var totalFriends : String
    var latitude : Double
    var longitude : Double
    var largePicture : String
    
    init(id: String, name: String, picture: String, birthday: String,
         sampleLikes: String, totalFriends: String, latitude : Double, longitude : Double, largePicture : String)
    {
        self.id = id
        self.name = name
        self.picture = picture
        self.birthday = birthday
        self.sampleLikes = sampleLikes
        self.totalFriends = totalFriends
        self.latitude = latitude
        self.longitude = longitude
        self.largePicture = largePicture
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM/dd/yyyy"
        
        let DOB = formatter.date(from: birthday)
        
        let dcf = DateComponentsFormatter()
        dcf.allowedUnits = .year
        dcf.unitsStyle = .full
        
        self.age = dcf.string(from: DOB!, to: Date())!
        self.age = self.age.replacingOccurrences(of: " years", with: "")
    }
}

