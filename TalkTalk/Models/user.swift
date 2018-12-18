//
//  Database.swift
//  TalkTalk
//
//  Created by Danielle Ahn on 9/29/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

class user {
    
    var id: Int
    var name: String?
    var account: String?
    var password: String?
    
    init(id:Int, name: String?, account: String?, password:String?){
        self.id = id
        self.name = name
        self.account = account
        self.password = password
    }
   
}
