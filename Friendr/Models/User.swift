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
    var age : Int
    var totalLikes : Int
    var sampleLikes: String
    var totalFriends : Int
    var sampleFriends : String
    
    init(id: String, name: String, picture: String, birthday: String, totalLikes: Int,
         sampleLikes: String, totalFriends: Int, sampleFriends: String)
    {
        self.id = id
        self.name = name
        self.picture = picture
        self.birthday = birthday
        self.totalLikes = totalLikes
        self.sampleLikes = sampleLikes
        self.totalFriends = totalFriends
        self.sampleFriends = sampleFriends
        
        var calendar : NSCalendar = NSCalendar.current as NSCalendar
        self.age = Calendar.current.dateComponents([.year], from: birthday, to: Date()).year!
    }
}

