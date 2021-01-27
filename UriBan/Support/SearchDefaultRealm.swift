//
//  SearchDefaultRealm.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/22.
//

import SwiftUI
import RealmSwift



func searchReam()  {
    print("-----------")
    let realm = try! Realm()
    print("Realm is located at:", realm.configuration.fileURL!)
    print("-----------")
}

struct SearchDefaultRealm: View {
    var body: some View {
        Button(action: {searchReam()}, label: {
            Text("defaut.realm 파일 위치 찾기,시뮬레이터로 실행하시오")
        })
    }
}

struct SearchDefaultRealm_Previews: PreviewProvider {
    static var previews: some View {
        SearchDefaultRealm()
    }
}
