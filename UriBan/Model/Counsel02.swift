//
//  Counsel02.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/27.
//

import SwiftUI
import RealmSwift

class Counsel02: Object,Identifiable {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var yymmdd: Date = Date()
    @objc dynamic var number = ""
    @objc dynamic var count = 0
    @objc dynamic var content = ""
    @objc dynamic var time = ""
}
