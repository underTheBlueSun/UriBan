//
//  StudentViewModel.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI
import RealmSwift

class StudentViewModel: ObservableObject {
    
    var uuid: String = ""
    var year = ""
    var school = ""
    var className = ""
    var myClass = false
    @Published var number = 0
    @Published var name = ""
    @Published var sex = "남자"
    @Published var telNo = ""
    @Published var address = ""
    @Published var picture = UIImage()
    @Published var memo = ""
    
    
    @Published var openNewPage = false
    
    @Published var students: [Student04] = []
    
    @Published var updateObject: Student04?
    
//    init() {
//
//        fetchData(uuid: uuid)
//    }
    
//    init(uuid: String) {
//        self.uuid = uuid
//        fetchData(uuid: uuid)
//    }

    
    func fetchData(uuid: String) {
        guard let dbRef = try? Realm() else { return }
//        let results = dbRef.objects(Student01.self).filter("school == %@", school)
        let results = dbRef.objects(Student04.self).filter("uuid == %@", uuid)
//        let results = dbRef.objects(Student01.self)
        // Displaying results
        self.students = results.compactMap({ (student) -> Student04? in return student })
    }
    
    // Add new data
    func addData(presentation: Binding<PresentationMode>) {

        let student = Student04()
        student.uuid = uuid
        student.year = year
        student.school = school
        student.className = className
        student.myClass = myClass
        student.number = number
        student.name = name
        student.sex = sex
        student.telNo = telNo
        student.address = address
//        student.picture = picture
        student.memo = memo
        
        

        
        if picture.pngData() != nil {
            // 프로필 사진 이미지 용량 줄이기, 안줄이면 에러: binary too big..
            let targetSize = CGSize(width: 100, height: 110)
            let scaledImage = picture.resizeImage(targetSize: targetSize)
            student.picture = NSData(data: scaledImage.pngData()!)
        }
        
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
        fetchData(uuid: uuid)

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

//        guard let updateData = updateObject else { return }

//        year = updateData.year
//        school = updateData.school
//        className = updateData.className
//        showMyClass = updateData.myClass

    }

    func deInitData() {
        name = ""
        telNo = ""
        address = ""
        memo = ""

    }
}


