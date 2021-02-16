//
//  CountByMonthView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/16.
//

import SwiftUI
//import SwiftUICharts

struct CountByMonthView: View {
    
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    var uribanID: String
    var uribanClassName: String
    
    init(uribanID: String, uribanClassName: String) {
        self.uribanID = uribanID
        self.uribanClassName = uribanClassName
    }
    
    func personsByMonth() -> [[Growth02]] {
        guard !growthViewModelData.growths.isEmpty else {return []}
      let dictionaryByMonth = Dictionary(grouping: growthViewModelData.growths, by: {
        Calendar.current.dateComponents([.month, .day], from: $0.yymmdd).day
//        $0.yymmdd
        
      }) 
//      let months = Array(1...12) // rotate this array if you want to go from October to September
        let months = Array(1...31)
      return months.compactMap({ dictionaryByMonth[$0] })
    }
    
    var body: some View {
        let monthAsInt = Calendar.current.dateComponents([.month], from: Date()).month
        
//        let list = ["1", "2", "3", "1", "2", "4"]
//        let ones = repeatElement(1, count: list.count)
//        let counted = Dictionary(zip(list, ones), uniquingKeysWith: +)
        
//        let ones = repeatElement(1, count: growthViewModelData.growths.count)
//        let counted = Dictionary(zip(growthViewModelData.growths, ones), uniquingKeysWith: +)
        
//        let list = ["a", "b", "c", "d", "a", "c"]
        
//        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        
        var grouped: [Int: Int] = [:]
        var groupedToArray: [Int] = []
        
//        let now = Date()
//        let date = DateFormatter() //Date 객체를 문자열로 바꾸기 위해 DateFomatter를 쓴다.
//        date.dateFormat = "yyyy-MM-dd HH:mm:ss" //DateFomatter는 디폴트가 내컴퓨터(로컬)이어서 서울시가 뜬다.
//        date.locale = Locale(identifier: "ko_kr") //한국의 시간을 지정해준다.
//        date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
        

        VStack {
            Text("aaaaa")
            
            Button(action: {
                for growth in growthViewModelData.growths {
                    grouped[Calendar.current.dateComponents([.month], from: growth.yymmdd).month!, default: 0] += 1
                }
                
                for item in grouped.sorted(by: <) {
                    groupedToArray.append(item.value)
                }
                
                print(grouped.sorted(by: <))
                print(groupedToArray)
                print(grouped.values)
                print(Array(grouped.values))
                print(grouped.map { $0.1 })
                
//                print(Calendar.current.date(byAdding: .month, value: 1, to: Date()))

                
            }, label: {
                Text("Button")
            })

//            List {
//              ForEach(personsByMonth(), id: \.self) { personsInMonth in
////                Section(header: Text(headerText(for: personsInMonth))) {
//                Section(header: Text(String(Calendar.current.dateComponents([.month, .day], from: personsInMonth[0].yymmdd).day!))) {
//                  ForEach(personsInMonth) { person in
//                    Text(person.name)
//                  } // end of ForEach
//                } // end of Section
//              } // end of ForEach
//            } // end of List
            
            Text("bbbbbb")
        } // Vstack
        .onAppear() {
            growthViewModelData.fetchData(uuid: uribanID)
        }
        
    } // body

}

//struct CountByMonthView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountByMonthView()
//    }
//}
