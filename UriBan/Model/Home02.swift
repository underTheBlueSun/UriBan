//
//  Home.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/19.
//  Copyright © 2021 underTheBlueSun. All rights reserved.
//

import SwiftUI
import RealmSwift

class Home02: Object,Identifiable {
    @objc dynamic var date: Date = Date()
    @objc dynamic var year = ""
    @objc dynamic var school = ""
    @objc dynamic var className = ""
    @objc dynamic var myClass = false
    @objc dynamic var image = ""
    
}
