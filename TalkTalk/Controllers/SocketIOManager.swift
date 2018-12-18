//
//  SocketIOManager.swift
//  TalkTalk
//
//  Created by Kibaek Kim on 8/12/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//


import UIKit
import SocketIO

class SocketIOManager: NSObject {


   
        //static let sharedInstance = Global()
    public var LogedInAccount: String?
    public var LogedInPassword: String?
    public var UID: String?
    
    
    static let sharedInstance = SocketIOManager()
    
    let manager = SocketManager(socketURL: URL(string: "http://192.168.1.131:9001")!, config: [.log(true), .connectParams(["kibaek" : "test"])])
    
    var socket:SocketIOClient!

    override init() {
        super.init()
        self.socket = manager.defaultSocket;
        //self.socket.connect();
    }

    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
   // func connectToServerWithNickname(nickname: String, completionHandler: (_ userList: [[String: AnyObject]]?) -> Void) {
   //     socket.emit("connectUser", nickname)
   //
   //     socket.on("userList") { ( dataArray, ack) -> Void in
   //         //completionHandler(userList: dataArray[0] as! [[String: AnyObject]])
   //     }
        
    //}
    
    func connectToServerWithAccount(account: String, password:String, completionHandler: @escaping (_ result: [[String: AnyObject]]?) -> Void) {

            
        socket.emit("login", account, password)
        print("test1")
        socket.on("loginResult") { ( dataArray, ack) -> Void in
  
         print("test2")
            completionHandler(dataArray as? [[String: AnyObject]])
           // NSLog("Tset")
           // print(tempObj["result"] as! NSObject)
        }
       
    }
    
    func getUserList(account: String, options:NSArray, completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
        
      

        socket.emit("getUser", SocketIOManager.sharedInstance.LogedInAccount!, options)
        
        socket.on("userListFromServer") { ( dataArray, ack) -> Void in
            
            
            completionHandler(dataArray as? [[String: AnyObject]])
            
        }
        
        
        /*
        socket.emit("login", account, password)
        
        socket.on("loginResult") { ( dataArray, ack) -> Void in
            
            
            completionHandler(dataArray as? [[String: AnyObject]])
        
        }*/
        
    }
    
    
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
    
  
    
}

