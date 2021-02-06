//
//  Student04.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/06.
//

import SwiftUI
import RealmSwift

class Student04: Object,Identifiable {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var year = ""
    @objc dynamic var school = ""
    @objc dynamic var className = ""
    @objc dynamic var myClass = false
    @objc dynamic var number = 0
    @objc dynamic var name = ""
    @objc dynamic var sex = ""
    @objc dynamic var telNo = ""
    @objc dynamic var address = ""
    @objc dynamic var picture = NSData()
    @objc dynamic var memo = ""
    
}
