//
//  SubjectViewModel.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/20.
//

import SwiftUI
import RealmSwift

class SubjectViewModel: ObservableObject {
    
    @Published var uuid: String = ""
    @Published var yymmdd: Date = Date()
    @Published var number = ""
    @Published var count = 0
    @Published var content = ""
    @Published var gubun = "과제"
    
    @Published var openNewPage = false
    
    @Published var subjects: [Subject03] = []
    
    @Published var updateObject: Subject03?
    
    // 전체 달성율
    @Published var cntGoal = 0
    @Published var cntCurrent = 0
    
    // 학생별 group by
    @Published var subjectsByStudent: [Subject03] = []
    @Published var cntByStudent: [(String,Int)] = [("",0)]
    
    // 월별 group by
    @Published var subjectsByMonth: [Subject03] = []
    @Published var cntByMonth: [Int: Int] = [:]
    @Published var achByMonth: [Int: Int] = [:]

    func fetchData(uuid: String) {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Subject03.self).filter("uuid == %@", uuid).sorted(byKeyPath: "yymmdd", ascending: false)
        self.subjects = results.compactMap({ (subject) -> Subject03? in return subject })
    }
    
    // 과제 검색
    func fetchSubject(uuid: String) {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Subject03.self).filter("uuid == '\(uuid)' and gubun == '과제'").sorted(byKeyPath: "yymmdd", ascending: false)
        self.subjects = results.compactMap({ (subject) -> Subject03? in return subject })
    }
    // 안내장 검색
    func fetchSheet(uuid: String) {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Subject03.self).filter("uuid == '\(uuid)' and gubun == '안내장'").sorted(byKeyPath: "yymmdd", ascending: false)
        self.subjects = results.compactMap({ (subject) -> Subject03? in return subject })
    }

    
    func addData(uuid: String, presentation: Binding<PresentationMode>) {
        let subject = Subject03()
        subject.uuid = uuid
        subject.yymmdd = Date()

        subject.number = number
        subject.count = count
        subject.content = content
        subject.gubun = gubun
        
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write {
            dbRef.add(subject)
            updateObject = nil
        } // try? dbRef.write

        // Updating UI
        fetchData(uuid: uuid)

        // Closing View
        presentation.wrappedValue.dismiss()

    } // addData
    
    func updData(presentation: Binding<PresentationMode>) {
        guard let dbRef = try? Realm() else { return }

        try? dbRef.write {
            guard let availableObject = updateObject else {
                return
            }
            availableObject.content = content
            availableObject.number = number
            availableObject.count = count
            availableObject.gubun = gubun
            
            updateObject = nil

        } // try? dbRef.write

        // Updating UI
        fetchData(uuid: uuid)

        // Closing View
        presentation.wrappedValue.dismiss()

    } // updData
    
    // Deleting Data
    func deleteData(object: Subject03, presentation: Binding<PresentationMode>) {
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write {

            dbRef.delete(object)
            fetchData(uuid: uuid)
        }
        presentation.wrappedValue.dismiss()
    }
    
    // Setting and Clearing Data
    func setUpInitialData() {
        guard let updateData = updateObject else { return }
        number = updateData.number
        count = updateData.count
        content = updateData.content
        gubun = updateData.gubun
        // onAppear 이상작동으로 여기에 uuid를 미리 세팅해둠
        self.uuid = updateData.uuid
    }

    func deInitData() {
        number = ""
        count = 0
        content = ""
        gubun = "과제"
    }
    
    //         let totalPages: Int = dbRef.objects(Subject03.self).sum(ofProperty: "count")

    // 전체 달성율 구하기
    func fetchSubjectTotal(uuid: String) {
        self.cntGoal = 0
        self.cntCurrent = 0
        guard let dbRef = try? Realm() else { return }
        // 전체 과제건수와 과제건수별 인원수 합산 구하기
//        self.cntGoal = results.compactMap({ (subject) -> Subject03? in return subject }).count
        self.cntGoal = dbRef.objects(Subject03.self).filter("uuid == '\(uuid)'").count
        self.cntCurrent = dbRef.objects(Subject03.self).filter("uuid == '\(uuid)'").sum(ofProperty: "count")
    }

    
    // 학생별 통계
    func fetchSubjectByStudent(uuid: String) {
        cntByStudent.removeAll()
        guard let dbRef = try? Realm() else { return }
        
        for i in 1...30 {
            // 이름 가져오기
            guard let studentObject = dbRef.objects(Student05.self).filter("uuid == '\(uuid)' and number == \(i)").first else { return }
            
            let results = dbRef.objects(Subject03.self).filter("uuid == '\(uuid)' and number CONTAINS '\(String(format: "%02d", i))'")
            self.subjectsByStudent = results.compactMap({ (subject) -> Subject03? in return subject })
            if self.subjectsByStudent.count != 0 {
                cntByStudent.append((studentObject.name,self.subjectsByStudent.count))
            }
            
        }
    }
    
    // 월별 건수와 달성율
    func fetchSubjectByMonth(uuid: String) {
        cntByMonth.removeAll()
        achByMonth.removeAll()
        
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Subject03.self).filter("uuid == '\(uuid)'")
        self.subjectsByMonth = results.compactMap({ (subject) -> Subject03? in return subject })
        
        // 월별 group by
        for subject in subjectsByMonth {
            cntByMonth[Calendar.current.dateComponents([.month], from: subject.yymmdd).month!, default: 0] += 1
            achByMonth[Calendar.current.dateComponents([.month], from: subject.yymmdd).month!, default: 0] += subject.count
        }
    }
    
    // 개인별 달성율 구하기
    func fetchSubjectIndi(uuid: String, number: Int) {
        self.cntGoal = 0
        self.cntCurrent = 0
        guard let dbRef = try? Realm() else { return }
        // 전체 과제건수와 과제건수별 인원수 합산 구하기
        self.cntGoal = dbRef.objects(Subject03.self).filter("uuid == '\(uuid)'").count
        self.cntCurrent = dbRef.objects(Subject03.self).filter("uuid == '\(uuid)' and number CONTAINS '\(String(format: "%02d", number))'").count
    }
  
}



