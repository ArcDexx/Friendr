//
//  FRLoginViewController.swift
//  Friendr
//
//  Created by epita on 16/12/16.
//  Copyright © 2016 epita. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class FRLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")
        
        if let accessToken = AccessToken.current {
            print("accessToken not nil")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "FRUserListTableViewController") as! FRUserListTableViewController
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        
        let loginButton = LoginButton(readPermissions: [.publicProfile ])
        
        loginButton.frame = CGRect(x: 0,y: self.view.frame.height - 50 , width: self.view.frame.width , height: 50)
        
        view.addSubview(loginButton)
    }

}
