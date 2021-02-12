//
//  Growth01.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/12.
//

import SwiftUI
import RealmSwift

class Growth01: Object,Identifiable {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var growthid: String = UUID().uuidString
    @objc dynamic var yymmdd: Date = Date()
    @objc dynamic var number = 0
    @objc dynamic var name = ""
    @objc dynamic var content = ""    
}
