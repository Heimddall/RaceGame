//
//  SettingModel.swift
//  Race
//
//  Created by Никита Суровцев on 9.07.23.
//

import Foundation

struct Setting {
    let settingName: String
    let type: SettingType
    var settingValue: Any
}


enum SettingType {
    case switchSetting
    case openSetting
}
