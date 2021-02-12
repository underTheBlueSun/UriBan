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
    
    @Published var number = 0
    @Published var name = ""
    @Published var sex = "남자"
    @Published var telNo = ""
    @Published var address = ""
    @Published var picture = UIImage()
    @Published var memo = ""
    
    
    @Published var openNewPage = false
    
    @Published var students: [Student05] = []
    
    @Published var updateObject: Student05?
    
//    init() {
//
//        fetchData(uuid: uuid)
//    }
    
//    init(uuid: String) {
//        self.uuid = uuid
//        fetchData(uuid: uuid)
//    }

    // 우리반에서 부를때
    func fetchData(uuid: String) {
        // 탭뷰, 학반생성에서 우리반 아이디 넘김
        self.uuid = uuid
        
        guard let dbRef = try? Realm() else { return }
//        let results = dbRef.objects(Student01.self).filter("school == %@", school)
        let results = dbRef.objects(Student05.self).filter("uuid == %@", uuid)
//        let results = dbRef.objects(Student01.self)
        // Displaying results
        self.students = results.compactMap({ (student) -> Student05? in return student })
    }
    
    // 우리반에서 부를때
//    func fetchData() {
//        guard let dbRef = try? Realm() else { return }
////        let results = dbRef.objects(Student01.self).filter("school == %@", school)
//        let results = dbRef.objects(Student05.self).filter("uuid == true")
////        let results = dbRef.objects(Student01.self)
//        // Displaying results
//        self.students = results.compactMap({ (student) -> Student05? in return student })
//
////        let uuid = dbRef.objects(Student05.self).filter("myClass == true").distinct(by: ["uuid"])
////        self.students = uuid.compactMap({ (student) -> Student05? in return student })
//
//        guard let firstTrue = dbRef.objects(Home03.self).filter("myClass == true").first else {return}
//        self.uuid = firstTrue.uuid
//        self.year = firstTrue.year
//        self.school = firstTrue.school
//        self.className = firstTrue.className
//        self.myClass = firstTrue.myClass
//
//    }
    
    // Add new data
    func addData(presentation: Binding<PresentationMode>) {
        let student = Student05()
        student.uuid = uuid
//        student.year = year
//        student.school = school
//        student.className = className
//        student.myClass = myClass
        student.number = number
        student.name = name.trimmingCharacters(in: .whitespaces)
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
            
            dbRef.add(student)
            updateObject = nil

            // 추가인지 수정인지 체크
//            guard let availableObject = updateObject else {
//                dbRef.add(student)
//                return
//            } // else

//            availableObject.year = year
//            availableObject.school = school
//            availableObject.className = className
//            availableObject.myClass = showMyClass

            // 수정후 + 버튼 누르면 제목,내용 살아 있어서 추가 함
//            updateObject = nil

        } // try? dbRef.write

        // Updating UI
        fetchData(uuid: uuid)

        // Closing View
        presentation.wrappedValue.dismiss()

    } // addData
    
    func updData(presentation: Binding<PresentationMode>) {
//        let student = Student05()
//        student.uuid = uuid
//        student.year = year
//        student.school = school
//        student.className = className
//        student.myClass = myClass
//        student.number = number
//        student.name = name.trimmingCharacters(in: .whitespaces)
//        student.sex = sex
//        student.telNo = telNo
//        student.address = address
////        student.picture = picture
//        student.memo = memo

        
        
        
        // Getting Reference
        guard let dbRef = try? Realm() else { return }

        // Writing Data
        try? dbRef.write {
            
//            dbRef.add(student)
//            updateObject = nil


            guard let availableObject = updateObject else {
//                dbRef.add(student)
                return
            }

            availableObject.name = name
            availableObject.sex = sex
            availableObject.telNo = telNo
            availableObject.address = address
            availableObject.memo = memo
            
            if picture.pngData() != nil {
                // 프로필 사진 이미지 용량 줄이기, 안줄이면 에러: binary too big..
                let targetSize = CGSize(width: 100, height: 110)
                let scaledImage = picture.resizeImage(targetSize: targetSize)
                availableObject.picture = NSData(data: scaledImage.pngData()!)
            }
            

            updateObject = nil

        } // try? dbRef.write

        // Updating UI
        fetchData(uuid: uuid)

        // Closing View
        presentation.wrappedValue.dismiss()

    } // updData
    
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
        number = updateData.number
        name = updateData.name
        sex = updateData.sex
        telNo = updateData.telNo
        address = updateData.address
//        picture = updateData.picture
        picture = UIImage(data: updateData.picture as Data) ?? UIImage(imageLiteralResourceName: "profile02")
        memo = updateData.memo
        

    }

    func deInitData() {
        
        name = ""
        sex = "남자"
        telNo = ""
        address = ""
        memo = ""
        picture = UIImage()
    }
}


