//
//  FirendViewController.swift
//  TalkTalk
//
//  Created by Danielle Ahn on 8/18/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit
import SocketIO

class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // Data model: These strings will be the data for the table view cells
    //var friends: [String] = ["Employee 1", "Employee 2", "Employee 3", "Employee 4", "Employee 6"]
    
    static let sharedInstance1 = FriendViewController()
    var friends: [String] = []
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "FriendTableCell"
    var friendsObj: NSDictionary = [String:NSArray]() as NSDictionary
    var selectedFriendName:String?
    
    @IBOutlet weak var FriendTable: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadUsers()
        print("Friend View appeared")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.FriendTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
       
        
        FriendTable.delegate = self
        FriendTable.dataSource = self
        
        
        print("Friend View loaded")
    }
    
   
    
    
    func loadUsers()
    {
        let paras = ["Test"]
       
        //var tempViewController = LoginViewController()
        SocketIOManager.sharedInstance.getUserList(account: SocketIOManager.sharedInstance.LogedInAccount! , options: paras as NSArray ,completionHandler: { (userList)  -> Void in
            
            //DispatchQueue.global(qos: .background).async {
            // Background Thread
            //DispatchQueue.main.async {
            // Run UI Updates or call completion block
            
            if userList != nil {
                
               let temp = self.convertoObject(inArray: userList!)
                
        
                //print(temp["List"] as Any )
                //print(temp["count"] as Any)
                //print(temp)
                
                //self.friends = temp["List"] as! [String]
                
                var fList = ["Kibaek Kim",
                    "Hui Hasbrouck",
                    "Ed Erving",
                    "Carlo Chickering",
                    "Mayola Matias",
                    "Percy Pitchford",
                    "Nicholas Neihoff",
                    "Carolann Chavarria",
                    "Luis Levins",
                    "Doreatha Donovan",
                    "Lorrine Littlejohn",
                    "Vickey Vrieze",
                    "Numbers Newbury",
                    "Norris Nuno",
                    "Keisha Kravetz",
                    "Cornelius Carico",
                    "Belinda Behrends",
                    "Tony Tidwell",
                    "Gerard Godbey",
                    "Milo Monk",
                    "Cleora Crittenden","Jaehun An"]
                fList.sort()
                self.friends = fList
                self.friendsObj = temp["Users"] as! NSDictionary
                //print(self.friendsObj)
                //print((self.friendsObj["Jaehun Ahn"] as! NSDictionary)["ID"])
                self.FriendTable.reloadData()
             
            }
            else
            {
                // for error handling process when result is null. maybe server fail... or
                print("test");
            }
            // }
            //}
            
        })
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }

    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.FriendTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        // set the text from the data model
        cell.textLabel?.text = self.friends[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = tableView.cellForRow(at: indexPath)!.textLabel!.text!
        
        print("You tapped cell number \(indexPath.row) and value is \(item).")
        self.selectedFriendName=item
        
        self.presentFriendViewController(Name: item)
        
        
        
    }
    
    // Use this method whenever you want to present your Login Screen
    private func presentFriendViewController(Name:String) {
        
        /*
        let ProfileVC = self.storyboard!.instantiateViewController(withIdentifier: "FriendInfoView") as! ProfileViewController
        ProfileVC.text = Name
        self.present(ProfileVC, animated: true, completion: nil)*/
        let ProfileVC = storyboard?.instantiateViewController(withIdentifier: "FriendInfoView") as! ProfileViewController
            ProfileVC.text = Name
            present(ProfileVC, animated:true)
    
        
        
        
    }
    
    private func convertoObject(inArray:Array<Any>)  -> NSDictionary {
        
        let tempArray = (inArray as NSArray)[0] as! NSObject
        //let type1 = type(of: tempArray)
        let dict = tempArray as! NSDictionary
        //print(dict["code"])
        return dict
    }
    
   
}
