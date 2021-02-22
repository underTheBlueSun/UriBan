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
    
    @Published var growthsByMonth: [Growth02] = []
    @Published var growthsByStudent: [Growth02] = []
    @Published var growthsPosiByIndi: [Growth02] = []
    @Published var growthsNegaByIndi: [Growth02] = []
    
    // 월별 group by
    @Published var groupedPositive: [Int: Int] = [:]
    @Published var groupedToArrPositive: [Double] = []
    @Published var groupedNegative: [Int: Int] = [:]
    @Published var groupedToArrNegative: [Double] = []
    // 학생별 group by
    @Published var groupedPositiveStudent: [(String,Int)] = [("",0)]
    @Published var groupedNegativeStudent: [(String,Int)] = [("",0)]
    // 개인별 group by
    @Published var groupedPosiIndi: [(String,Int)] = [("",0)]
//    @Published var groupedToArrPosiIndi: [Double] = []
    @Published var groupedNegaIndi: [(String,Int)] = [("",0)]
//    @Published var groupedToArrNegaIndi: [Double] = []

    
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
//        let results = dbRef.objects(Growth02.self).filter("uuid == %@", uuid)
        let results = dbRef.objects(Growth02.self).filter("uuid == %@", uuid)
//        let results = dbRef.objects(Growth02.self).filter("uuid = '3457F0C5-4517-48DD-8689-990BACF4E455' and name CONTAINS '/1/'")
        self.growths = results.compactMap({ (growth) -> Growth02? in return growth })
        
        // 월별 group by
//        for growth in growths {
//            grouped[Calendar.current.dateComponents([.month], from: growth.yymmdd).month!, default: 0] += 1
//        }
//        for item in grouped.sorted(by: <) {
//            groupedToArray.append(Double(item.value))
//        }
    }
    
    func addData(uuid: String, presentation: Binding<PresentationMode>) {
        let growth = Growth02()
        growth.uuid = uuid
        growth.yymmdd = Date()
        
        // 한달후 더미 데이터 집어넣기
//        growth.yymmdd = Calendar.current.date(byAdding: .month,  value: 5, to: Date())!

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
            availableObject.status = status
            
            updateObject = nil

        } // try? dbRef.write

        // Updating UI
        fetchData(uuid: uuid)

        // Closing View
        presentation.wrappedValue.dismiss()

    } // updData
    
    // Deleting Data
    func deleteData(object: Growth02, presentation: Binding<PresentationMode>) {
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write {

            dbRef.delete(object)
            fetchData(uuid: uuid)
        }
        presentation.wrappedValue.dismiss()
    }
    
    // AddPageView.onAppear() 될때
    // Setting and Clearing Data
    func setUpInitialData() {
        guard let updateData = updateObject else { return }
//        number = updateData.number
        name = updateData.name
        content = updateData.content
        status = updateData.status
        // onAppear 이상작동으로 여기에 uuid를 미리 세팅해둠
        self.uuid = updateData.uuid
    }

    func deInitData() {
        name = ""
        content = ""
        status = "긍정"
    }
    
    // 월별 긍정 통계
    func fetchPositiveByMonth(uuid: String) {
        
        groupedPositive.removeAll()
        groupedToArrPositive.removeAll()
        
        guard let dbRef = try? Realm() else { return }
//        let results = dbRef.objects(Growth02.self).filter("uuid == %@", uuid)
        let results = dbRef.objects(Growth02.self).filter("uuid == '\(uuid)' and status == '긍정'")
        self.growthsByMonth = results.compactMap({ (growth) -> Growth02? in return growth })
        
        // 월별 group by
        for growth in growthsByMonth {
            groupedPositive[Calendar.current.dateComponents([.month], from: growth.yymmdd).month!, default: 0] += 1
        }
        for item in groupedPositive.sorted(by: <) {
            groupedToArrPositive.append(Double(item.value))
        }
    }
    // 월별 부정 통계
    func fetchNegativeByMonth(uuid: String) {
        
        groupedNegative.removeAll()
        groupedToArrNegative.removeAll()
        
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Growth02.self).filter("uuid == '\(uuid)' and status == '부정'")
        self.growthsByMonth = results.compactMap({ (growth) -> Growth02? in return growth })
        
        // 월별 group by
        for growth in growthsByMonth {
            groupedNegative[Calendar.current.dateComponents([.month], from: growth.yymmdd).month!, default: 0] += 1
        }
        for item in groupedNegative.sorted(by: <) {
            groupedToArrNegative.append(Double(item.value))
        }
    }
    
    // 학생별 긍정 통계
    func fetchPositiveByStudent(uuid: String) {
        groupedPositiveStudent.removeAll()
        guard let dbRef = try? Realm() else { return }
        
        for i in 1...30 {
            // 이름 가져오기
            guard let studentObject = dbRef.objects(Student05.self).filter("uuid == '\(uuid)' and number == \(i)").first else { return }
            
            let results = dbRef.objects(Growth02.self).filter("uuid == '\(uuid)' and status == '긍정' and name CONTAINS '\(String(format: "%02d", i))'")
            self.growthsByStudent = results.compactMap({ (growth) -> Growth02? in return growth })
            if self.growthsByStudent.count != 0 {
                groupedPositiveStudent.append((studentObject.name,self.growthsByStudent.count))
            }
            
        }
    }

    // 학생별 부정 통계
    func fetchNegativeByStudent(uuid: String) {
        groupedNegativeStudent.removeAll()
        guard let dbRef = try? Realm() else { return }
        
        for i in 1...30 {
            // 이름 가져오기
            guard let studentObject = dbRef.objects(Student05.self).filter("uuid == '\(uuid)' and number == \(i)").first else { return }

            let results = dbRef.objects(Growth02.self).filter("uuid == '\(uuid)' and status == '부정' and name CONTAINS '\(String(format: "%02d", i))'")
            self.growthsByStudent = results.compactMap({ (growth) -> Growth02? in return growth })
            if self.growthsByStudent.count != 0 {
                groupedNegativeStudent.append((studentObject.name,self.growthsByStudent.count))
            }
        }
    }
    
    // 개인별 긍정 통계
    func fetchPositiveByIndi(uuid: String, number: Int) {
        groupedPosiIndi.removeAll()
//        groupedToArrPosiIndi.removeAll()
        guard let dbRef = try? Realm() else { return }
//        guard let studentObject = dbRef.objects(Student05.self).filter("uuid == '\(uuid)' and number == \(number)").first else { return }
        
        let results = dbRef.objects(Growth02.self).filter("uuid == '\(uuid)' and status == '긍정' and name CONTAINS '\(String(format: "%02d", number))'")
        self.growthsPosiByIndi = results.compactMap({ (growth) -> Growth02? in return growth })
        // 월별 group by
        for growth in growthsPosiByIndi {
            groupedPosiIndi[Calendar.current.dateComponents([.month], from: growth.yymmdd).month!, default: 0] += 1
        }
//        for item in groupedPosiIndi.sorted(by: <) {
//            groupedToArrPosiIndi.append(Double(item.value))
//        }
        
//        print("uuid: " + uuid)
//        print("number: " + String(number))
//        print(groupedPosiIndi.sorted(by: <))

    }

    // 개인별 부정 통계
    func fetchNegativeByIndi(uuid: String, number: Int) {
        groupedNegaIndi.removeAll()
//        groupedToArrNegaIndi.removeAll()
        
        guard let dbRef = try? Realm() else { return }
        
        let results = dbRef.objects(Growth02.self).filter("uuid == '\(uuid)' and status == '부정' and name CONTAINS '\(String(format: "%02d", number))'")
        self.growthsNegaByIndi = results.compactMap({ (growth) -> Growth02? in return growth })
        // 월별 group by
        for growth in growthsNegaByIndi {
            groupedNegaIndi[Calendar.current.dateComponents([.month], from: growth.yymmdd).month!, default: 0] += 1
        }
//        for item in groupedNegaIndi.sorted(by: <) {
//            groupedToArrNegaIndi.append(Double(item.value))
//        }
    }

    
    
}


