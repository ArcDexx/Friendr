//
//  FRUserListTableViewController.swift
//  Friendr
//
//  Created by Dalila Watts on 24/12/2016.
//  Copyright © 2016 epita. All rights reserved.
//

import UIKit
import AlamofireImage
import FirebaseDatabase
import SwiftyJSON

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var nameAgeLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
}

class FRUserListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var users : Array<User> = []
    var ref: FIRDatabaseReference!
    let cellReuseIdentifier = "ProfileCell"
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fillUserList()
        
        self.tableView.addSubview(self.refreshControl)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FRUserListTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    public func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.users.removeAll()
        tableView.reloadData()
        fillUserList()
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell:ProfileTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ProfileTableViewCell
        
        let imageUrl = URL(string: users[indexPath.row].picture)
        let nameAge = users[indexPath.row].name + ", " + users[indexPath.row].age
        
        cell.profilePic.layer.borderWidth = 1
        cell.profilePic.layer.masksToBounds = false
        cell.profilePic.layer.borderColor = UIColor.black.cgColor
        cell.profilePic.layer.cornerRadius = cell.profilePic.frame.height/2
        cell.profilePic.clipsToBounds = true
        
        cell.nameAgeLabel.text = nameAge
        cell.profilePic.af_setImage(withURL: imageUrl!)
    
        print("cellForRow called")
        
        return cell
    }
    
    func fillUserList()
    {
        ref = FIRDatabase.database().reference()
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let jsonUsers = JSON(snapshot.value!)
            
            for (key, user) in jsonUsers {
                let user = User(id: user["id"].stringValue,
                                name: user["name"].stringValue,
                                picture: user["picture"].stringValue,
                                birthday: user["birthday"].stringValue,
                                sampleLikes: "",
                                totalFriends: user["friends_count"].stringValue,
                                latitude: user["latitude"].doubleValue,
                                longitude: user["longitude"].doubleValue,
                                largePicture: user["largePicture"].stringValue)
                
                self.users.append(user)
                UserStore.userStore.users.append(user)
                
                self.tableView.beginUpdates()
                let indexPath = IndexPath(row: self.users.count - 1, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            }
        })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  
        UserStore.userStore.selectedUser = users[indexPath.row]
        performSegue(withIdentifier: "profileSegue", sender: self)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    

}
