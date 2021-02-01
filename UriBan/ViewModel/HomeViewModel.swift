//
//  HomeViewModel.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/19.
//  Copyright © 2021 underTheBlueSun. All rights reserved.
//

import SwiftUI
import RealmSwift

class HomeViewModel: ObservableObject {
    
//    @Published var date = ""
    @Published var year = ""
    @Published var school = ""
    @Published var className = ""
    @Published var showMyClass = false
    
    // 스윗한 스위프트 p302 는 조금 다름
    @Published var openNewPage = false
    
    // Fetched Data
    @Published var homes: [Home03] = []
    
    // Data Updation
    @Published var updateObject: Home03?
    
    init() {
        fetchData()
    }

    // Fetching Data
    func fetchData() {
        
        
        guard let dbRef = try? Realm() else { return }
//        let results = dbRef.objects(Card.self).filter("title = '\(title)'")
        
        let results = dbRef.objects(Home03.self)
        
        // Displaying results
        self.homes = results.compactMap({ (home) -> Home03? in
            return home
        })
    }
    
    // Add new data
    func addData(presentation: Binding<PresentationMode>) {
        
        let home = Home03()
//        home.date = Date()
        home.year = year
        home.school = school
        home.className = className
        home.myClass = showMyClass
        home.image = "classImage0" + String(self.homes.count + 1)
        
        // Getting Reference
        guard let dbRef = try? Realm() else { return }
        
        // Writing Data
        try? dbRef.write {
            
            // 추가인지 수정인지 체크
            guard let availableObject = updateObject else {
                
                
                // 추가일 때 우리반을 체크하면 이전 우리반 true를 false로 수정
                if home.myClass == true {
                    guard let beforeTrue = dbRef.objects(Home03.self).filter("myClass == true").first else {
                        dbRef.add(home)
                        return
                    }
                    beforeTrue.myClass = false
                }
                
                dbRef.add(home)
                return
            } // else
            
            // 수정할 때 우리반을 체크하면 기존의 우리반 체크된 것을 false로 수정
            if showMyClass == true {
                guard let beforeTrue = dbRef.objects(Home03.self).filter("myClass == true").first else {
                    availableObject.year = year
                    availableObject.school = school
                    availableObject.className = className
                    availableObject.myClass = showMyClass
                    
                    // 수정후 + 버튼 누르면 제목,내용 살아 있어서 추가 함
                    updateObject = nil
                    return
                }
                beforeTrue.myClass = false
            }
            
            availableObject.year = year
            availableObject.school = school
            availableObject.className = className
            availableObject.myClass = showMyClass
            
            // 수정후 + 버튼 누르면 제목,내용 살아 있어서 추가 함
            updateObject = nil
            
        } // try? dbRef.write
        
        // Updating UI
        fetchData()
        
        // Closing View
        presentation.wrappedValue.dismiss()
        
    } // addData
    
    // Deleting Data
    func deleteData(object: Home03) {
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write {
            
            dbRef.delete(object)
            
            fetchData()
        }
    }
    
    // AddPageView.onAppear() 될때
    // Setting and Clearing Data
    func setUpInitialData() {
        
        guard let updateData = updateObject else { return }
        
        //Home에서 "Update Item"버튼을 터치하면 AddPageView화면에 제목,내용 넘겨주기
        // Checking if it's update object and assigning values
        year = updateData.year
        school = updateData.school
        className = updateData.className
        showMyClass = updateData.myClass
        
    }
    
    func deInitData() {
        year = ""
        school = ""
        className = ""
        showMyClass = false
        
    }
}


