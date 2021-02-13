//
//  Growth02.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/13.
//

import SwiftUI
import RealmSwift

class Growth02: Object,Identifiable {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var yymmdd: Date = Date()
    @objc dynamic var number = 0
    @objc dynamic var name = ""
    @objc dynamic var content = ""
    @objc dynamic var status = "긍정"
}

