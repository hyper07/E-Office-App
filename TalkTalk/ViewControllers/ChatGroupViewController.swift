//
//  ChatGroupViewController.swift
//  TalkTalk
//
//  Created by Kibaek Kim on 8/19/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit
import SocketIO

class ChatGroupViewController: UIViewController, LynnBubbleViewDataSource  {
    
    var arrChatTest:Array<LynnBubbleData> = []
    
    
    func bubbleTableView(numberOfRows bubbleTableView: LynnBubbleTableView) -> Int {
         return self.arrChatTest.count
    }
    
    func bubbleTableView(dataAt index: Int, bubbleTableView: LynnBubbleTableView) -> LynnBubbleData {
       return self.arrChatTest[index]
    }
    

    static let sharedInstance = ChatGroupViewController()
    
    var Messages: [String] = []
    //var Messages: Array<LynnBubbleData> = []
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "ChatViewIdentify"

    var chatTitle: String?
    
    var navigationStatus = true
    
    
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView: LynnBubbleTableView!
    
    @IBOutlet weak var MessageBox: UITextField!
    
    
    
    
   // @IBAction func backToTable(_ sender: Any) {
        
   //    print("back button clicked")
        
   // }
    
    @IBAction func SendButton(_ sender: Any) {
        
       //var messageInfo: [String: AnyObject]
       //var messageDictionary = [String: AnyObject]()
       //messageDictionary["nickname"] = "kibaek" as String
       //messageDictionary["message"] = MessageBox.text! as String
       //messageDictionary["date"] = "12/23/2018" as String
       
        //let userMe = LynnUserData(userUniqueId: "123", userNickName: "me", userProfileImage: nil, additionalInfo: nil)
        let userMe = LynnUserData(userUniqueId: "123", userNickName: "me", userProfileImage: UIImage(named: "ico_myprofile"), additionalInfo: nil)
     

        let messageMine = MessageBox.text
        let tommorow = Date().addingTimeInterval(0)
        
        
        self.arrChatTest.append(LynnBubbleData(userData: userMe, dataOwner: .me, message: messageMine, messageDate: tommorow))
        
        self.tableView.reloadData()
        
        //Messages.append(MessageBox.text!)
        //Messages.append(messageDictionary)
        
        DispatchQueue.main.async(execute: {
            //self.tableView.reloadData()
        })
        
        MessageBox.resignFirstResponder()
        MessageBox.text=""
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.delegate = self
        //tableView.dataSource = self
        
        tableView.bubbleDelegate = self
        tableView.bubbleDataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.separatorStyle = .none
        
        
       
    }
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.separatorStyle = .none
        self.ChatViewTitla.title = self.chatTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Bar", style: .done, target: self, action:  #selector(NavToggle))
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        
        //fetchChatGroupList()
    }
    */
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if (DataManage.sharedInstance.appprovedToDoTitle == "")
        {
            self.testChatData2()
        }
        else
        {
            self.testChatData3()
        }
       
        print("Chat Group View appeared")
        
   
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // navigationItem.title = "One"
        //navigationItem.title = self.chatTitle
        self.title = self.chatTitle
    }
    
    @objc func BackToTable() {
        print("Back Button Clicked")
      //dismissViewControllerAnimated(true, completion: nil)
        
       //let ChatViewController1 = ChatViewController()
        
       //self.present(ChatViewController1, animated: false, completion: nil)
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
   
    }
    
    
    
    func testChatData () {
        /*
         let userMe = LynnUserData(userUniqueId: "123", userNickName: "me", userProfileImage: nil, additionalInfo: nil)
         let userSomeone = LynnUserData(userUniqueId: "234", userNickName: "you", userProfileImage: UIImage(named: "ico_girlprofile"), additionalInfo: nil)
         
         let yesterDay = Date().addingTimeInterval(-60*60*24)
         
         
         let bubbleData:LynnBubbleData = LynnBubbleData(userData: userMe, dataOwner: .me, message: "test", messageDate: yesterDay)
         
         self.arrChatTest.append(bubbleData)  //삽입
         
         print(index)
         
         let image_width = LynnAttachedImageData(named: "cat_width.jpg")
         
         self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: Date(), attachedImage: image_width))  //삽입
         self.arrChatTest.append(bubbleData) //삽입
         
         
         self.tbBubbleDemo.reloadData()
         
         */
        var messageMine = "aslkjfdlkjglkjsdjglksjdflkjlskvjkldjv lkjclvkjvlkjvlklkjlcklck"
        var messageSomeone = "asklfd"
        
        let userMe = LynnUserData(userUniqueId: "123", userNickName: "me", userProfileImage: nil, additionalInfo: nil)
        let userSomeone = LynnUserData(userUniqueId: "234", userNickName: "Kibaek", userProfileImage: UIImage(named: "ico_girlprofile"), additionalInfo: nil)
        let yesterDay = Date().addingTimeInterval(-60*60*24)
        for index in 0..<10 {
            
            if index % 4 == 0 {
                //                let bubbleData:LynnBubbleData = LynnBubbleDataMine(userID: "123",userNickname: "me" , profile: nil, text: messageMine, image: nil, date: NSDate())
                
                let bubbleData:LynnBubbleData = LynnBubbleData(userData: userMe, dataOwner: .me, message: messageMine, messageDate: yesterDay)
                
                self.arrChatTest.append(bubbleData)
                messageMine += " " + messageMine
            }else {
                
                let bubbleData:LynnBubbleData = LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: messageSomeone, messageDate: yesterDay)
                self.arrChatTest.append(bubbleData)
                messageSomeone += " " + messageSomeone
            }
            
        }
        
        let image_width = LynnAttachedImageData(named: "cat_width.jpg")
        let image_height = LynnAttachedImageData(named: "cat_height.jpg")
        
        let imgDataCat1 = LynnAttachedImageData(url: "http://kstatic.inven.co.kr/upload/2017/06/22/bbs/i13321623699.jpg")
        let imgDataCat2 = LynnAttachedImageData(url: "http://kstatic.inven.co.kr/upload/2017/06/22/bbs/i13328661393.jpg")
        let imgDataCat3 = LynnAttachedImageData(url: "http://kstatic.inven.co.kr/upload/2017/06/22/bbs/i13360836567.jpg", placeHolderImage: UIImage(named: "message_loading"), failureImage: UIImage(named: "message_loading_fail"))
        let imgDataCatFail = LynnAttachedImageData(url: "http://kstatic.inven.co.kr/upload/2017/06/22/bbs/i133608365621117.jpg", placeHolderImage: UIImage(named: "message_loading"), failureImage: UIImage(named: "message_loading_fail"))
        
        self.arrChatTest.append(LynnBubbleData(userData: userMe, dataOwner: .me, message: nil, messageDate: Date(), attachedImage: image_width))
        self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: Date(), attachedImage: image_height))
        self.arrChatTest.append(LynnBubbleData(userData: userMe, dataOwner: .me, message: nil, messageDate: Date(), attachedImage: imgDataCat1))
        self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: Date(), attachedImage: imgDataCat2))
        self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: Date(), attachedImage: imgDataCat3))
        self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: Date(), attachedImage: imgDataCatFail))
        self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: Date(), attachedImage: imgDataCat2))
        
        messageMine = "aslkjfdlkjglkjsdjglksjdflkjlskvjkldjv lkjclvkjvlkjvlklkjlcklck"
        messageSomeone = "asklfd"
        let tommorow = Date().addingTimeInterval(60*60*24)
        
        for index in 0..<10 {
            
            if index % 4 == 0 {
                //                let bubbleData:LynnBubbleData = LynnBubbleDataMine(userID: "123",userNickname: "me" , profile: nil, text: messageMine, image: nil, date: NSDate())
                
                let bubbleData:LynnBubbleData = LynnBubbleData(userData: userMe, dataOwner: .me, message: messageMine, messageDate: tommorow)
                
                self.arrChatTest.append(bubbleData)
                messageMine += " " + messageMine
            }else {
                
                let bubbleData:LynnBubbleData = LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: messageSomeone, messageDate: tommorow)
                self.arrChatTest.append(bubbleData)
                messageSomeone += " " + messageSomeone
            }
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func testChatData2() {
      
        var messageMine = ""
        var messageSomeone = "Please approve payment request for purchasing Mold."
        
        //let userMe = LynnUserData(userUniqueId: "123", userNickName: "me", userProfileImage: nil, additionalInfo: nil)
        let userMe = LynnUserData(userUniqueId: "123", userNickName: "me", userProfileImage: UIImage(named: "ico_myprofile"), additionalInfo: nil)
        let userSomeone = LynnUserData(userUniqueId: "234", userNickName: "Kibaek", userProfileImage: UIImage(named: "ico_myprofile"), additionalInfo: nil)
        let yesterDay = Date().addingTimeInterval(-60*60*24)
 
                
        let bubbleData:LynnBubbleData = LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: messageSomeone, messageDate: yesterDay)
        self.arrChatTest.append(bubbleData)
   
      
        let imgDataCatFail = LynnAttachedImageData(url: "https://www.jewelerstoystore.com/v/vspfiles/photos/f410-2.jpg", placeHolderImage: UIImage(named: "message_loading"), failureImage: UIImage(named: "message_loading_fail"))
        
        //self.arrChatTest.append(LynnBubbleData(userData: userMe, dataOwner: .me, message: nil, messageDate: Date(), attachedImage: image_width))
        //self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: Date(), attachedImage: image_height))

        self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: yesterDay, attachedImage: imgDataCatFail))

        
       
        
        self.tableView.reloadData()
        
    }
    
    
    func testChatData3() {
        
        var messageMine = ""
        var messageSomeone = "Please approve payment request for purchasing Mold."
        
        //let userMe = LynnUserData(userUniqueId: "123", userNickName: "me", userProfileImage: nil, additionalInfo: nil)
        let userMe = LynnUserData(userUniqueId: "123", userNickName: "me", userProfileImage: UIImage(named: "ico_girlprofile"), additionalInfo: nil)
        let userSomeone = LynnUserData(userUniqueId: "234", userNickName: "Kibaek", userProfileImage: UIImage(named: "ico_myprofile"), additionalInfo: nil)
        let yesterDay = Date().addingTimeInterval(-60*60*24)
        
        
        let bubbleData:LynnBubbleData = LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: messageSomeone, messageDate: yesterDay)
        self.arrChatTest.append(bubbleData)
        
  
        let imgDataCatFail = LynnAttachedImageData(url: "https://www.jewelerstoystore.com/v/vspfiles/photos/f410-2.jpg", placeHolderImage: UIImage(named: "message_loading"), failureImage: UIImage(named: "message_loading_fail"))
        
        //self.arrChatTest.append(LynnBubbleData(userData: userMe, dataOwner: .me, message: nil, messageDate: Date(), attachedImage: image_width))
        //self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: Date(), attachedImage: image_height))
        
        self.arrChatTest.append(LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: nil, messageDate: yesterDay, attachedImage: imgDataCatFail))
        
        
        messageMine = "Approved"
        let tommorow = Date().addingTimeInterval(0)
        
        
        self.arrChatTest.append(LynnBubbleData(userData: userMe, dataOwner: .me, message: messageMine, messageDate: tommorow))
        
        self.tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Messages.count
    }

    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        // set the text from the data model
        cell.textLabel?.text = self.Messages[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.row%2==0
        {
            cell.textLabel?.textAlignment = NSTextAlignment.right
            
        }
        else
        {
            cell.textLabel?.textAlignment = NSTextAlignment.left
        }
        //cell.lblMessageDetails.textAlignment = NSTextAlignment.Right
        
        
        return cell
    }
    
   
    
    /*
    func fetchChatGroupList() {
        if let uid = FirebaseDataService.instance.currentUserUid {
            FirebaseDataService.instance.userRef.child(uid).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? Dictionary<String, Int> {
                    for (key, _) in dict {
                        
                        FirebaseDataService.instance.groupRef.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                            if let data = snapshot.value as? Dictionary<String, AnyObject> {
                                let group = Group(key: key, data: data)
                                self.groups.append(group)
                                
                                DispatchQueue.main.async(execute: {
                                    self.tableView.reloadData()
                                })
                            }
                        })
                    }
                }
            })
        }
    }
    */

    
   // }
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "chatting", sender: groups[indexPath.row].key)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        cell.textLabel?.text = groups[indexPath.row].name
        return cell
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "userList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userList" {
            let userListVC = segue.destination as! UserListViewController
            let chatGroupVC = sender as! ChatGroupViewController
            userListVC.chatGroupVC = chatGroupVC
        } else if segue.identifier == "chatting" {
 
 let chatVC = segue.destination as! ViewController
            chatVC.groupKey = sender as? String
        }
    }
 */
    
}

extension ChatGroupViewController : LynnBubbleViewDelegate {
    // optional
    func bubbleTableView(_ bubbleTableView: LynnBubbleTableView, didSelectRowAt index: Int) {
        
        let alert = UIAlertController(title: nil, message: "selected index : " + "\(index)", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close",
                                        style: .default) { (action: UIAlertAction!) -> Void in
        }
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func bubbleTableView(_ bubbleTableView: LynnBubbleTableView, didLongTouchedAt index: Int) {
        let alert = UIAlertController(title: nil, message: "LongTouchedAt index : " + "\(index)", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close",
                                        style: .default) { (action: UIAlertAction!) -> Void in
        }
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func bubbleTableView(_ bubbleTableView: LynnBubbleTableView, didTouchedAttachedImage image: UIImage, at index: Int) {
        let alert = UIAlertController(title: nil, message: "AttachedImage index : " + "\(index)", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close",
                                        style: .default) { (action: UIAlertAction!) -> Void in
        }
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func bubbleTableView(_ bubbleTableView: LynnBubbleTableView, didTouchedUserProfile userData: LynnUserData, at index: Int) {
        let alert = UIAlertController(title: nil, message: "UserProfile index : " + "\(index)", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close",
                                        style: .default) { (action: UIAlertAction!) -> Void in
        }
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
}

