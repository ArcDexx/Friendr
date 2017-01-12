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
import SwiftyJSON
import FirebaseDatabase
import CoreLocation

class FRLoginViewController: UIViewController, LoginButtonDelegate, CLLocationManagerDelegate {

    var ref: FIRDatabaseReference!
    let locationManager = CLLocationManager()
    var lat = 0.0
    var long = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        self.locationManager.requestAlwaysAuthorization()
        

        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
            
            self.lat = locValue.latitude
            self.long = locValue.longitude
        }
        
        ref = FIRDatabase.database().reference()
        
        let loginButton = LoginButton(readPermissions: [.publicProfile, .custom("user_photos"), .custom("user_likes"), .custom("user_birthday")])
        
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
            FacebookHandler.getFacebookData(lat: lat, long: long)
            performSegue(withIdentifier: "toListFromLogin", sender: self)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Logged Out")
    }
}
