//
//  room.swift
//  TalkTalk
//
//  Created by Danielle Ahn on 9/29/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//
class room {
    
    var id: Int
    var name: String?
    var type: String?

    init(id:Int, name: String?, type: String?){
        self.id = id
        self.name = name
        self.type = type
    }
    
}
