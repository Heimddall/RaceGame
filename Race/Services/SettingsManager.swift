//
//  SettingsManager.swift
//  Race
//
//  Created by Никита Суровцев on 9.07.23.
//

import Foundation

class SettingsManager {
    
    static var shared = SettingsManager()
    
    private init() {}
    
    @UserDefault(key: "isMusicOn", defaultValue: false)
    var isMusicOn: Bool
    
    @UserDefault(key: "isSoundOn", defaultValue: false)
    var isSoundOn: Bool
    
    @UserDefault(key: "nameOfObstacles", defaultValue: "Cars")
    var nameOfObstacles: String
    
    @UserDefault(key: "codeOfColor", defaultValue: "000000")
    var codeOfColor: String
    
    @UserDefault(key: "userName", defaultValue: "User")
    var userName: String
}
