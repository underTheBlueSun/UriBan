//
//  StudentViewModel.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI
import RealmSwift

class StudentViewModel: ObservableObject {
    
    @Published var uuid: String = ""
    @Published var year = ""
    @Published var school = ""
    @Published var className = ""
    @Published var myClass = false
    @Published var number = ""
    @Published var name = ""
    @Published var sex = ""
    @Published var telNo = ""
    @Published var address = ""
    @Published var picture = ""
    @Published var memo = ""
    
    
    @Published var openNewPage = false
    
    @Published var students: [Student02] = []
    
    @Published var updateObject: Student02?
    
    init() {
        
        fetchData(uuid: uuid)
    }
    
//    init(uuid: String) {
//        self.uuid = uuid
//        fetchData(uuid: uuid)
//    }
        
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
    func addData(presentation: Binding<PresentationMode>) {

        let student = Student02()
        student.uuid = uuid
        student.year = year
        student.school = school
        student.className = className
        student.myClass = myClass

        // Getting Reference
        guard let dbRef = try? Realm() else { return }

        // Writing Data
        try? dbRef.write {

            // 추가인지 수정인지 체크
            guard let availableObject = updateObject else {

                dbRef.add(student)
                return
            } // else

//            availableObject.year = year
//            availableObject.school = school
//            availableObject.className = className
//            availableObject.myClass = showMyClass

            // 수정후 + 버튼 누르면 제목,내용 살아 있어서 추가 함
            updateObject = nil

        } // try? dbRef.write

        // Updating UI
//        fetchData()

        // Closing View
        presentation.wrappedValue.dismiss()

    } // addData
    
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
    func setUpInitialData() {

        guard let updateData = updateObject else { return }

//        year = updateData.year
//        school = updateData.school
//        className = updateData.className
//        showMyClass = updateData.myClass

    }

    func deInitData() {
//        year = ""
//        school = ""
//        className = ""
//        showMyClass = false

    }
}


