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

class FRLoginViewController: UIViewController, LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")
    
        
        let loginButton = LoginButton(readPermissions: [.publicProfile ])
        loginButton.delegate = self
        
        loginButton.frame = CGRect(x: 0,y: self.view.frame.height - 50 , width: self.view.frame.width , height: 50)
        
        view.addSubview(loginButton)
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("Cancelled")
        default:
            print("Logged In")
            performSegue(withIdentifier: "toListFromLogin", sender: self)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Logged Out")
    }
}
