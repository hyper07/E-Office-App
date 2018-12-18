//
//  ProfileViewController.swift
//  TalkTalk
//
//  Created by Kibaek Kim on 8/19/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit
import CallKit

class ProfileViewController: UIViewController {
    
    var text=""
    @IBOutlet weak var ChatTo: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func OpenChat(_ sender: Any) {
        
        print("Chat Button clicked")
       
        
        if DataManage.sharedInstance.chatroom.contains(self.text) {
            
            DataManage.sharedInstance.selectedvalue = self.text
            DataManage.sharedInstance.newChat = true

            
           // ChatViewController.sharedInstance.viewChatView(chatName:self.text)
            
           // let ChatViewController1 = storyboard?.instantiateViewController(withIdentifier: "ChatTableIdentify") as! ChatViewController
           //self.present(ChatViewController1, animated:false, completion:nil)
            
            //TabViewControllerIdentifier
         
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabViewControllerIdentifier") as! UITabBarController
            
            vc.selectedIndex = 1
            self.present(vc, animated: true, completion: nil)
            
           // let objVC: ChatViewController? = ChatViewController()
           // let aObjNavi = UINavigationController(rootViewController: objVC!)
           // self.navigationController?.pushViewController(aObjNavi, animated: true)
            print("Navi controller")
            
        }
        else{
            print("no")
            //DataManage.sharedInstance.chatroom.append(self.text)
            //DataManage.sharedInstance.chatroom.insert(self.text, at: 0)
            print(DataManage.sharedInstance.chatroom)
            DataManage.sharedInstance.chatroom.append(self.text)
            
        }
     
        
        
    }
    
    
    @IBAction func makeCall(_ sender: Any) {
        
        let alert = UIAlertController(title: "1-917-xxx-xxxx", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { action in
            print("Called")
            //"+1-(917)-304-8404".makeAColl()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
        
    }
    
    @IBAction func CloseView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Friend Chat View Appeared")
     
        //ChatTo?.text = FriendViewController.sharedInstance1.selectedFriendName
        ChatTo?.text = self.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        profileImage?.layer.cornerRadius = (profileImage?.frame.size.width ?? 0.0) / 2
        profileImage?.clipsToBounds = true
        profileImage?.layer.borderWidth = 3.0
        profileImage?.layer.borderColor = UIColor.white.cgColor
        profileImage.image = UIImage(named: "kibaek")
        
        loadNextVC()
        print("Friend Chat View loaded")
    }
    
    func loadNextVC() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            // Code to push/present new view controller
        }
    }
    
    
    
    
}
