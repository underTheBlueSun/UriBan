//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/14.
//

import SwiftUI
import SwiftUICharts

struct ItemByMonthView: View {
    
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
        let array: [Double] = [1,10,20,30,50,100,70, 20, 0]
        
        let monthAsInt = Calendar.current.dateComponents([.month], from: Date()).month
        
        let singers = ["Ed Sheeran", "Ariana Grande", "Taylor Swift", "Adele Adkins"]
        let groupedByLength = Dictionary(grouping: singers) { $0.count }
//        let groupedByFirst = Dictionary(grouping: singers) { $0.first! }
        
        VStack {
            Text("aaaaa")

//            MultiLineChartView(data: [(array, GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Title")
            
            List {
              ForEach(personsByMonth(), id: \.self) { personsInMonth in
//                Section(header: Text(headerText(for: personsInMonth))) {
                Section(header: Text(String(Calendar.current.dateComponents([.month, .day], from: personsInMonth[0].yymmdd).day!))) {
                  ForEach(personsInMonth) { person in
                    Text(person.name)
                  } // end of ForEach
                } // end of Section
              } // end of ForEach
            } // end of List
            
            Text("bbbbbb")
        } // Vstack
        .onAppear() {
            growthViewModelData.fetchData(uuid: uribanID)
        }
        
    } // body

}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
