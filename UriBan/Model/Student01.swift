//
//  Student01.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/26.
//  Copyright © 2021 underTheBlueSun. All rights reserved.
//

import SwiftUI
import RealmSwift

class Student01: Object,Identifiable {
    @objc dynamic var date = Date()
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
