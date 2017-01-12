//
//  FRProfileViewController.swift
//  Friendr
//
//  Created by epita on 11/01/17.
//  Copyright © 2017 epita. All rights reserved.
//

import UIKit
import AlamofireImage

class FRProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var ageLabel : UILabel!
    @IBOutlet weak var friendsLabel : UILabel!
    @IBOutlet weak var profilePic : UIImageView!
    @IBOutlet weak var mapButton : UIButton!
    
    let user = UserStore.userStore.selectedUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapButton.layer.cornerRadius = 5
        mapButton.layer.borderWidth = 1
        mapButton.layer.borderColor = UIColor.init(colorLiteralRed: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0).cgColor
        
        let imageUrl = URL(string: (user?.largePicture)!)

        nameLabel.text = user?.name
        ageLabel.text = (user?.age)! + " years old"
        friendsLabel.text = (user?.totalFriends)! + " friends"
        
        profilePic.layer.borderWidth = 2
        profilePic.layer.borderColor = UIColor.black.cgColor
        profilePic.af_setImage(withURL: imageUrl!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showOnMap(_ sender: Any)
    {
        performSegue(withIdentifier: "profileToMap", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "profileToMap"
        {
            let mapController = segue.destination as! FRMapViewController
            mapController.fromProfile = true
        }
    }
    

}
