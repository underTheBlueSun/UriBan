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
    @Published var content = ""
    
    @Published var openNewPage = false
    
    @Published var subjects: [Subject01] = []
    
    @Published var updateObject: Subject01?
    // 월별 group by
    @Published var groupedPositive: [Int: Int] = [:]
    @Published var groupedToArrPositive: [Double] = []
    @Published var groupedNegative: [Int: Int] = [:]
    @Published var groupedToArrNegative: [Double] = []

    func fetchData(uuid: String) {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Subject01.self).filter("uuid == %@", uuid)
        self.subjects = results.compactMap({ (subject) -> Subject01? in return subject })
    }
    
    func addData(uuid: String, presentation: Binding<PresentationMode>) {
        let subject = Subject01()
        subject.uuid = uuid
        subject.yymmdd = Date()

        subject.number = number
        subject.content = content
        
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
            
            updateObject = nil

        } // try? dbRef.write

        // Updating UI
        fetchData(uuid: uuid)

        // Closing View
        presentation.wrappedValue.dismiss()

    } // updData
    
    // Deleting Data
    func deleteData(object: Subject01, presentation: Binding<PresentationMode>) {
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
        content = updateData.content
        // onAppear 이상작동으로 여기에 uuid를 미리 세팅해둠
        self.uuid = updateData.uuid
    }

    func deInitData() {
        number = ""
        content = ""
    }
    
    // 월별 통계
    func fetchPositiveByGroup(uuid: String) {
        
        groupedPositive.removeAll()
        groupedToArrPositive.removeAll()
        
        guard let dbRef = try? Realm() else { return }
//        let results = dbRef.objects(Growth02.self).filter("uuid == %@", uuid)
        let results = dbRef.objects(Subject01.self).filter("uuid == '\(uuid)'")
        self.subjects = results.compactMap({ (subject) -> Subject01? in return subject })
        
        // 월별 group by
        for subject in subjects {
            groupedPositive[Calendar.current.dateComponents([.month], from: subject.yymmdd).month!, default: 0] += 1
        }
        for item in groupedPositive.sorted(by: <) {
            groupedToArrPositive.append(Double(item.value))
        }
        
    }
    
    func fetchNegativeByGroup(uuid: String) {
        
        groupedNegative.removeAll()
        groupedToArrNegative.removeAll()
        
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Subject01.self).filter("uuid == '\(uuid)'")
        self.subjects = results.compactMap({ (subject) -> Subject01? in return subject })
        
        // 월별 group by
        for subject in subjects {
            groupedNegative[Calendar.current.dateComponents([.month], from: subject.yymmdd).month!, default: 0] += 1
        }
        for item in groupedNegative.sorted(by: <) {
            groupedToArrNegative.append(Double(item.value))
        }
        
    }
    
}


