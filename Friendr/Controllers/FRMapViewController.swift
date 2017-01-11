//
//  FRMapViewController.swift
//  Friendr
//
//  Created by epita on 11/01/17.
//  Copyright © 2017 epita. All rights reserved.
//

import UIKit
import GoogleMaps

class FRMapViewController: UIViewController {

    var users : Array<User> = UserStore.userStore.users
    var currentUser : User = UserStore.userStore.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: currentUser.latitude,
                                              longitude: currentUser.longitude,
                                              zoom: 7)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        for user in self.users
        {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(user.latitude, user.longitude)
            marker.title = user.name
            marker.snippet = "Age: " + user.age + "  Friends: " + user.totalFriends
            marker.map = mapView
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
