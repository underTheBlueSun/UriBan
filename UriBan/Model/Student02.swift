//
//  Student02.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/30.
//

import SwiftUI
import RealmSwift

class Student02: Object,Identifiable {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var year = ""
    @objc dynamic var school = ""
    @objc dynamic var className = ""
    @objc dynamic var myClass = false
    @objc dynamic var number = ""
    @objc dynamic var name = ""
    @objc dynamic var sex = ""
    @objc dynamic var telNo = ""
    @objc dynamic var address = ""
    @objc dynamic var picture = ""
    @objc dynamic var memo = ""
    
}

