//
//  Session.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init() {}
    
    var userId: Int = 0
    var token: String = ""
    
    let cliendId = "8024869"
    //8024869
    let version = "5.131"
}
//5.131
