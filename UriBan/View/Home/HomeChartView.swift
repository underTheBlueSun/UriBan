//
//  HomeChartView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/16.
//

import SwiftUI
import SwiftUICharts

struct HomeChartView: View {
    
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    
    var uuid: String
    var className: String
    
    init(uuid: String, className: String) {
        self.uuid = uuid
        self.className = className
    }
    
    var body: some View {
        
//        var grouped: [Int: Int] = [:]
//        var groupedToArray: [Double] = []
        
        VStack {
            Button(action: {
                print(uuid)
                print(growthViewModelData.groupedToArrPositive)
                print(growthViewModelData.groupedToArrNegative)
//                print(growthViewModelData.fetchDataByGroup(uuid: uuid).map { String($0) }.joined(separator: "-"))

            }, label: {
                Text("Button")
            })
            
            Text(uuid)
//            Text(growthViewModelData.fetchDataByGroup(uuid: uuid).map { String($0) }.joined(separator: "-"))
            MultiLineChartView(data: [(growthViewModelData.groupedToArrPositive, GradientColors.blue), (growthViewModelData.groupedToArrNegative, GradientColors.orngPink)], title: "월별 관찰추이")
            
        } // VStack
        .onAppear(perform: {
            growthViewModelData.fetchPositiveByGroup(uuid: uuid)
            growthViewModelData.fetchNegativeByGroup(uuid: uuid)
            
//            for growth in growthViewModelData.growths {
//                grouped[Calendar.current.dateComponents([.month], from: growth.yymmdd).month!, default: 0] += 1
//            }
//
//            for item in grouped.sorted(by: <) {
//                groupedToArray.append(Double(item.value))
//            }
        }) // onAppear()
        
    } // body
}

struct HomeChartView_Previews: PreviewProvider {
    static var previews: some View {
        HomeChartView(uuid: "3457F0C5-4517-48DD-8689-990BACF4E455", className: "5-2반")
    }
}
