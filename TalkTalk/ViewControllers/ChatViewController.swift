//
//  ChatViewController.swift
//  TalkTalk
//
//  Created by Danielle Ahn on 8/18/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit
import SocketIO

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Data model: These strings will be the data for the table view cells
    //var chatroom: [String] = ["E-Approval(#1122)", "Voucher(#1232)", "PO/Payment(#4221)", "CSR(#MM18-2423)", "RSR(#2322)"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "ChatRoomCell"
    var selectedvalue:String?
    
    var newChat = false
    
    static let sharedInstance = ChatViewController()
    
    @IBOutlet weak var ChatRoomTable: UITableView!
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
*/
    /*
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if ChatRoomTable.isEditing{
            sender.title="Edit"
            ChatRoomTable.setEditing(false, animated:true)
        }  else{
            sender.title="Done"
            ChatRoomTable.setEditing(true, animated:true)
        }
        
    }
    */
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
       //self.navigationController?.setNavigationBarHidden(true, animated: false)
        print("Chat View appeared")
        
        
        setBadge(count: 1,chatitem: "Expense(#3333)")

        
    }
    
    
    func setBadge(count: Int, chatitem: String) {
        
        
        
        var accesoryBadge = UILabel()
        var string = "1"
        accesoryBadge.text = string
        accesoryBadge.textColor = UIColor.white
        accesoryBadge.font = UIFont(name: "Lato-Regular", size: 16)
        accesoryBadge.textAlignment = NSTextAlignment.center
        accesoryBadge.layer.cornerRadius = 4
        accesoryBadge.clipsToBounds = true
        
        accesoryBadge.frame = CGRect(x: 50, y: 0, width: 20, height: 20)
            
            //CGRectMake(0, 0, WidthForView(string, font: UIFont(name: "Lato-Light", size: 16), height: 20)+20, 20)
        
        let indexPath = NSIndexPath(row: 2, section: 0)
        let cell = ChatRoomTable.cellForRow(at: indexPath as IndexPath)
        cell?.accessoryView = accesoryBadge
        //ChatRoomTable.
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        print("Chat View will appeared")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.ChatRoomTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        ChatRoomTable.delegate = self
        ChatRoomTable.dataSource = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if DataManage.sharedInstance.newChat{
            //self.viewDidAppear(true)
            DataManage.sharedInstance.newChat = false
             self.viewChatView(chatName:DataManage.sharedInstance.selectedvalue)
            
            print("Chat Group View called")
        }
        
        
        print("Chat View loaded")
    }
    
    // swipe to delete
    func tableView(_ tableView: UITableView, commit editngStyle:UITableViewCellEditingStyle, forRowAt indexPath:IndexPath){
        
        let rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Rate") { (action , indexPath ) -> Void in
            self.isEditing = false
            print("Rate button pressed")
        }
        
        if editngStyle == UITableViewCellEditingStyle.delete{
            DataManage.sharedInstance.chatroom.remove(at:indexPath.row)
            ChatRoomTable.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManage.sharedInstance.chatroom.count
    }
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.ChatRoomTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = DataManage.sharedInstance.chatroom[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        
        let selectedName = ChatRoomTable.cellForRow(at: indexPath)!.textLabel!.text!
        print(ChatRoomTable.cellForRow(at: indexPath)!.textLabel!.text!)
        viewChatView(chatName: selectedName)
        
      
        
    }
    
    func viewChatView(chatName:String)
    {
        self.selectedvalue = chatName
        let ChatViewController1 = storyboard?.instantiateViewController(withIdentifier: "ChatViewIdentify") as! ChatGroupViewController
   
        ChatViewController1.chatTitle = chatName
        self.navigationController?.pushViewController(ChatViewController1, animated: true)
 
        
    }
    /*
    func viewChatView(chatName:String)
    {
        self.selectedvalue = chatName
        let ChatViewController1 = storyboard?.instantiateViewController(withIdentifier: "ChatViewIdentify") as! ChatGroupViewController
        
        ChatViewController1.chatTitle = chatName
        //ChatViewController.ChatViewTitla.title = ChatRoomTable.cellForRow(at: indexPath)!.textLabel!.text!
        //self.navigationController?.pushViewController(ChatViewController1, animated: true)
        //self.present(ChatViewController1, animated:true, completion:nil)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        //let presentedVC = self.storyboard!.instantiateViewController(withIdentifier: "ChatViewIdentify") as! ChatGroupViewController
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "Back"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle("", for: .normal)
        //backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        
       // self.ChatViewTitla.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        
        ChatViewController1.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        let nvc = UINavigationController(rootViewController: ChatViewController1)
        present(nvc, animated: false, completion: nil)
        
        
    }
    */
    @objc func didTapCloseButton(_ sender: Any) {
        if let presentedVC = presentedViewController {
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            presentedVC.view.window!.layer.add(transition, forKey: kCATransition)
        }
        
        dismiss(animated: false, completion: nil)
        
       
    }
    
    
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
}
