//
//  Home03.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/30.
//

import SwiftUI
import RealmSwift

class Home03: Object,Identifiable {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var year = ""
    @objc dynamic var school = ""
    @objc dynamic var className = ""
    @objc dynamic var myClass = false
    @objc dynamic var image = ""
    
}
