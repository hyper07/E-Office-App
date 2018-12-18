//
//  ViewController.swift
//  TalkTalk
//
//  Created by Kibaek Kim on 8/12/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit
import SocketIO
//import SocketIOManager

class ViewController: UIViewController {
    
    
    public var account : String? = nil
    var password : String? = nil
    //var users : NSObject? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Presenting the Login Screen View Controller
        self.presentLoginScreenViewController()
    }
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentLoginScreenViewController()
        
        
        
        if self.nickname == nil {
           // askForNickname()
           self.displayMsg(title: "Title", msg: "Some text for a message", style: .alert, dontRemindKey: "UserHasSeenMsg")
        }
 
      
        
        
    }
   */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Use this method whenever you want to present your Login Screen
    private func presentLoginScreenViewController() {
        let storyboard = UIStoryboard(name: "LoginScreen", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewControllerIdentifier")
        self.present(loginVC, animated: true, completion: nil)
    }
    
    
    
   // func askForNickname() {
        //let alertController = UIAlertController(title: "TalkTalk", message: "Please enter a nickname:", preferredStyle: UIAlertControllerStyle.alert)
       
       // alertController.addTextField(configurationHandler: nil)
       /*
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in
            let textfield = alertController.textFields![0]
            if textfield.text?.characters.count == 0 {
                self.askForNickname()
            }
            else {
                self.nickname = textfield.text
                
                SocketIOManager.sharedInstance.connectToServerWithNickname(nickname:  SocketIOManager.sharedInstance.nickname, completionHandler: { (userList) -> Void in
                    
                    DispatchQueue.global(qos: .background).async {
                        // Background Thread
                        DispatchQueue.main.async {
                            // Run UI Updates or call completion block
                            if userList != nil {
                                self.users = userList as! NSObject
                                //self.tblUserList.reloadData()
                                //self.tblUserList.hidden = false
                            }
                        }
                    }
              
                })
            }
        }
        
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
        */
        
        
   // }
    
    
    
    func displayMsg(title : String?, msg : String,
                    style: UIAlertControllerStyle = .alert,
                    dontRemindKey : String? = nil) {
        if dontRemindKey != nil,
            UserDefaults.standard.bool(forKey: dontRemindKey!) == true {
            return
        }
        
        let ac = UIAlertController.init(title: title,
                                        message: msg, preferredStyle: style)
        ac.addAction(UIAlertAction.init(title: "OK",
                                        style: .default, handler: nil))
        
        if dontRemindKey != nil {
            ac.addAction(UIAlertAction.init(title: "Don't Remind",
                                            style: .default, handler: { (aa) in
                                                UserDefaults.standard.set(true, forKey: dontRemindKey!)
                                                UserDefaults.standard.synchronize()
            }))
        }
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }

}



