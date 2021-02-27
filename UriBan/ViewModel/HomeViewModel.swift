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
    @Published var showMyClass = true
    
    // 스윗한 스위프트 p302 는 조금 다름
    @Published var openNewPage = false
    
    // Fetched Data
    @Published var homes: [Home03] = []
    
    // Data Updation
    @Published var updateObject: Home03?
    
    // 처음 앱이 활성화 되면 우리반 uuid, 학반을 변수에 저장
    @Published var uribanID = ""
    @Published var uribanClassName = ""
    
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
    
    // 처음 앱이 활성화 되거나, 학반 추가를 할때 우리반 uuid, 학반을 변수에 저장
    func setUriBanID() {
        guard let dbRef = try? Realm() else { return }
        guard let firstTrue = dbRef.objects(Home03.self).filter("myClass == true").first else {
            uribanID = ""
            return
            
        }
        self.uribanID = firstTrue.uuid
        self.uribanClassName = firstTrue.className
    }
    
    // Add new data
    func addData(presentation: Binding<PresentationMode>) {
        
        let home = Home03()
//        home.uuid = UUID().uuidString // Home03()에서 이미 생성하니 따로 생성할 필요없다
        home.year = year
        home.school = school.trimmingCharacters(in: .whitespaces)
        home.className = className.trimmingCharacters(in: .whitespaces)
        home.myClass = showMyClass
        home.image = "classImage" + String(self.homes.count + 1)
        
        // Getting Reference
        guard let dbRef = try? Realm() else { return }
        
        // Writing Data
        try? dbRef.write {
            
            // 추가인지 수정인지 체크
            guard let availableObject = updateObject else {
                
                
                // 반 추가할때 우리반을 클릭하면 이전 우리반 true를 false로 수정
                if home.myClass == true {
                    guard let beforeTrue = dbRef.objects(Home03.self).filter("myClass == true").first else {
                        // 최초 추가이거나 이전 우리반이 없으면
                        dbRef.add(home)
                        self.uribanID = home.uuid
                        return
                    }
                    // 이전에 우리반이 있었으면
                    beforeTrue.myClass = false
                    
                    // 반 추가할때 우리반을 클릭하면 이전 우리반이었던 학생 모두 false
                    for beforeTrueStudent in dbRef.objects(Student04.self).filter("myClass == true") {
                        beforeTrueStudent.myClass = false
                    }
                }
                                
                dbRef.add(home)
                self.uribanID = home.uuid  // 이전에 우리반이 있던 없던 우리반을 클릭하면 무조건 우리반id 세팅
                
                return
            } // else
            
            // 반 수정할때 우리반을 클릭하면 이전의 우리반 체크된 것을 false로 수정
            if showMyClass == true {
                guard let beforeTrue = dbRef.objects(Home03.self).filter("myClass == true").first else {
                    // 이전 우리반이 없으면
                    availableObject.year = year
                    availableObject.school = school
                    availableObject.className = className
                    availableObject.myClass = showMyClass
                    
                    // 수정후 + 버튼 누르면 제목,내용 살아 있어서 추가 함
                    updateObject = nil
                    return
                }
                
                beforeTrue.myClass = false
                
                // 반 수정할때 우리반을 클릭하면 이전의 우리반이었던 학생 모두 false
                for beforeTrueStudent in dbRef.objects(Student04.self).filter("myClass == true") {
                    beforeTrueStudent.myClass = false
                }
                
                // 반 수정할때 우리반을 클릭하면 새로 우리반이 된 모든 학생 true
                for beforeFalseStudent in dbRef.objects(Student04.self).filter("uuid == %@", availableObject.uuid) {
                    beforeFalseStudent.myClass = true
                }
                
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
        if self.homes.count == 0 {
            showMyClass = true
        }else {
            showMyClass = false
        }
        
        
    }
}


