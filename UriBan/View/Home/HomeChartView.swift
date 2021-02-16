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
//                print("aaaa")
//                print(groupedToArray)

            }, label: {
                Text("Button")
            })
            
            Text(uuid)
            Text(growthViewModelData.groupedToArray.map { String($0) }.joined(separator: "-"))
            MultiLineChartView(data: [(growthViewModelData.groupedToArray, GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Title")
            
        } // VStack
        .onAppear(perform: {
            growthViewModelData.fetchData(uuid: uuid)
            
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
