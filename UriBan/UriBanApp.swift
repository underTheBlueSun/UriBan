//
//  UriBanApp.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/22.
// ... 

import SwiftUI

@main
struct UriBanApp: App {
    

    
    var body: some Scene {
        WindowGroup {
            MainTabView().environment(\.colorScheme, .light)
//            SearchDefaultRealm() // 파인더 열고 shift+cmd+g 누르고 경로 복사해서 집어넣기
//            ContentView()
        }
    }
}
