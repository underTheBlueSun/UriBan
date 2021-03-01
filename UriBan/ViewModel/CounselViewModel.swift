//
//  CounselViewModel.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/27.
//

import SwiftUI
import RealmSwift

class CounselViewModel: ObservableObject {
    
    @Published var uuid: String = ""
    @Published var yymmdd: Date = Date()
    @Published var number = ""
    @Published var count = 0
    @Published var content = ""
    @Published var time = ""
    
    @Published var openNewPage = false
    
    @Published var counsels: [Counsel02] = []
    
    @Published var updateObject: Counsel02?
    
    @Published var counselsByMonth: [Counsel02] = []
    // 월별 group by
    @Published var groupedCounsel: [Int: Int] = [:]
    @Published var groupedToArrCounsel: [Double] = []
    
    func fetchData(uuid: String) {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Counsel02.self).filter("uuid == %@", uuid).sorted(byKeyPath: "yymmdd", ascending: false)
        self.counsels = results.compactMap({ (counsel) -> Counsel02? in return counsel })
    }
    
    func fetchStu(uuid: String, number: Int) {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Counsel02.self).filter("uuid == '\(uuid)' and number CONTAINS '\(String(format: "%02d", number))'")
        self.counsels = results.compactMap({ (counsel) -> Counsel02? in return counsel })
    }

    
    func addData(uuid: String, presentation: Binding<PresentationMode>) {
        let counsel = Counsel02()
        counsel.uuid = uuid
        counsel.yymmdd = Date()

        counsel.number = number
        counsel.count = count
        counsel.content = content
        counsel.time = time
        
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write {
            dbRef.add(counsel)
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
            availableObject.time = time
            
            updateObject = nil

        } // try? dbRef.write

        // Updating UI
        fetchData(uuid: uuid)

        // Closing View
        presentation.wrappedValue.dismiss()

    } // updData
    
    // Deleting Data
    func deleteData(object: Counsel02, presentation: Binding<PresentationMode>) {
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
        time = updateData.time
        // onAppear 이상작동으로 여기에 uuid를 미리 세팅해둠
        self.uuid = updateData.uuid
    }

    func deInitData() {
        number = ""
        count = 0
        content = ""
        time = ""
    }
    
    // 월별 통계
    func fetchByMonth(uuid: String) {
        
        groupedCounsel.removeAll()
        groupedToArrCounsel.removeAll()
        
        guard let dbRef = try? Realm() else { return }
//        let results = dbRef.objects(Growth02.self).filter("uuid == %@", uuid)
        let results = dbRef.objects(Counsel02.self).filter("uuid == '\(uuid)'")
        self.counselsByMonth = results.compactMap({ (counsel) -> Counsel02? in return counsel })
        
        // 월별 group by
        for counsel in counselsByMonth {
            groupedCounsel[Calendar.current.dateComponents([.month], from: counsel.yymmdd).month!, default: 0] += 1
        }
        for item in groupedCounsel.sorted(by: <) {
            groupedToArrCounsel.append(Double(item.value))
        }
    }
        
}

