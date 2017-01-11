//
//  UserStore.swift
//  Friendr
//
//  Created by epita on 11/01/17.
//  Copyright © 2017 epita. All rights reserved.
//

import Foundation

final class UserStore {
    static let userStore = UserStore()
    var users : Array<User>!
    var currentUser : User!
    var selectedUser : User!
    
    init()
    {
        self.users = []
        self.currentUser = nil
        self.selectedUser = nil
    }
}
