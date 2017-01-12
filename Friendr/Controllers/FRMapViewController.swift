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
    var fromProfile : Bool = false
    var camera : GMSCameraPosition? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fromProfile
        {
            self.camera = GMSCameraPosition.camera(withLatitude: UserStore.userStore.selectedUser.latitude,
                                                  longitude: UserStore.userStore.selectedUser.longitude,
                                                  zoom: 10)
        }
        else
        {
            self.camera = GMSCameraPosition.camera(withLatitude: currentUser.latitude,
                                                  longitude: currentUser.longitude,
                                                  zoom: 7)
        }
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera!)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        for user in self.users
        {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(user.latitude, user.longitude)
            marker.title = user.name
            marker.snippet = "Age: " + user.age + "  Friends: " + user.totalFriends
            
            let imageUrl = URL(string: user.picture)
            let markerView : UIImageView = UIImageView(frame: CGRect(x:0, y:0, width: 100, height: 100));
            markerView.af_setImage(withURL: imageUrl!)
            
            marker.map = mapView
            
            if fromProfile && user.id == UserStore.userStore.selectedUser.id
            {
                mapView.selectedMarker = marker
            }
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
