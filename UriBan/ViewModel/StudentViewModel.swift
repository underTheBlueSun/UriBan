//
//  StudentViewModel.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI
import RealmSwift

class StudentViewModel: ObservableObject {
    
    @Published var uuid: String
    @Published var year = ""
    @Published var school = ""
    @Published var className = ""
    @Published var MyClass = false
    @Published var number = ""
    @Published var name = ""
    @Published var sex = ""
    @Published var telNo = ""
    @Published var address = ""
    @Published var picture = ""
    @Published var memo = ""
    
    
    @Published var openNewPage = false
    
    @Published var students: [Student02] = []
    
    init(uuid: String) {
        self.uuid = uuid
        fetchData(uuid: uuid)
    }
        
    func fetchData(uuid: String) {
        guard let dbRef = try? Realm() else { return }
//        let results = dbRef.objects(Student01.self).filter("school == %@", school)
        let results = dbRef.objects(Student02.self).filter("uuid == %@", uuid)
//        let results = dbRef.objects(Student01.self)
        // Displaying results
        self.students = results.compactMap({ (student) -> Student02? in return student })
    }
    
//    func addData(date: Date) {
//        print("333")
////    func addData(school: String) {
//
//        let student = Student01()
//        student.date = date
////        student.school = school
//
//            // Getting Reference
//        guard let dbRef = try? Realm() else { return }
//
//            // Writing Data
//            try? dbRef.write {
//
//                    dbRef.add(student)
//                print("444")
//
//            }
//
//    } // addData
        
        
    
    // Add new data
//    func addData(thisYear: String, presentation: Binding<PresentationMode>) {
//
//        let home = Home02()
//        home.date = Date()
//        home.year = thisYear
//        home.school = school
//        home.className = className
//        home.myClass = showMyClass
//        home.image = "classImage0" + String(self.homes.count + 1)
//
//        // Getting Reference
//        guard let dbRef = try? Realm() else { return }
//
//        // Writing Data
//        try? dbRef.write {
//
//            // 추가인지 수정인지 체크
//            guard let availableObject = updateObject else {
//
//
//                // 추가일 때 우리반을 체크하면 이전 우리반 true를 false로 수정
//                if home.myClass == true {
//                    guard let beforeTrue = dbRef.objects(Home02.self).filter("myClass == true").first else {
//                        dbRef.add(home)
//                        return
//                    }
//                    beforeTrue.myClass = false
//                }
//
//                dbRef.add(home)
//                return
//            } // else
//
//            // 수정할 때 우리반을 체크하면 기존의 우리반 체크된 것을 false로 수정
//            if showMyClass == true {
//                guard let beforeTrue = dbRef.objects(Home02.self).filter("myClass == true").first else {
//                    availableObject.year = year
//                    availableObject.school = school
//                    availableObject.className = className
//                    availableObject.myClass = showMyClass
//
//                    // 수정후 + 버튼 누르면 제목,내용 살아 있어서 추가 함
//                    updateObject = nil
//                    return
//                }
//                beforeTrue.myClass = false
//            }
//
//            availableObject.year = year
//            availableObject.school = school
//            availableObject.className = className
//            availableObject.myClass = showMyClass
//
//            // 수정후 + 버튼 누르면 제목,내용 살아 있어서 추가 함
//            updateObject = nil
//
//        } // try? dbRef.write
//
//        // Updating UI
//        fetchData()
//
//        // Closing View
//        presentation.wrappedValue.dismiss()
//
//    } // addData
    
    // Deleting Data
//    func deleteData(object: Home02) {
//        guard let dbRef = try? Realm() else { return }
//        try? dbRef.write {
//
//            dbRef.delete(object)
//
//            fetchData()
//        }
//    }
    
    // AddPageView.onAppear() 될때
    // Setting and Clearing Data
//    func setUpInitialData() {
//
//        guard let updateData = updateObject else { return }
//
//        //Home에서 "Update Item"버튼을 터치하면 AddPageView화면에 제목,내용 넘겨주기
//        // Checking if it's update object and assigning values
//        year = updateData.year
//        school = updateData.school
//        className = updateData.className
//        showMyClass = updateData.myClass
//
//    }
//
//    func deInitData() {
//        year = ""
//        school = ""
//        className = ""
//        showMyClass = false
//
//    }
}


