//
//  GrowthViewModel.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/13.
//

import SwiftUI
import RealmSwift

class GrowthViewModel: ObservableObject {
    
    @Published var uuid: String = ""
//    @Published var growthid: String = ""
    @Published var yymmdd: Date = Date()
    @Published var number = 0
    @Published var name = ""
    @Published var content = ""
    @Published var status = "긍정"
    
    @Published var openNewPage = false
    
    @Published var growths: [Growth02] = []
    
    @Published var updateObject: Growth02?
    
//    init() {
//
//        fetchData(uuid: uuid)
//    }
    
//    init(uuid: String) {
//        self.uuid = uuid
//        fetchData(uuid: uuid)
//    }

    // 행발 탭을 누르면
    func fetchData(uuid: String) {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Growth02.self).filter("uuid == %@", uuid)
//        let results = dbRef.objects(Growth02.self).filter("uuid = '3457F0C5-4517-48DD-8689-990BACF4E455' and name CONTAINS '/1/'")
        self.growths = results.compactMap({ (growth) -> Growth02? in return growth })
    }
    
    func addData(presentation: Binding<PresentationMode>) {
        let growth = Growth02()
        growth.uuid = uuid
        growth.yymmdd = Date()
        // Growth03 만들어서 number를 String으로 바꾼후 growth.name = name 대신 growth.number = number 로 변경해야 함
//        growth.number = number
        growth.name = name
        growth.content = content
        growth.status = status
        
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write {
            dbRef.add(growth)
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
//            availableObject.number = number
            availableObject.name = name
            
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
//        number = updateData.number
        name = updateData.name
        content = updateData.content
        status = updateData.status
    }

    func deInitData() {
        name = ""
        content = ""
        status = "긍정"
    }
}


