//
//  Subject01.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/20.
//

import SwiftUI
import RealmSwift

class Subject01: Object,Identifiable {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var yymmdd: Date = Date()
    @objc dynamic var number = ""
    @objc dynamic var content = ""
}
