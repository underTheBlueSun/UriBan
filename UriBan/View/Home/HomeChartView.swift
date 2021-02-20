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
    
    @State var openChartView = false
    
    init(uuid: String, className: String) {
        self.uuid = uuid
        self.className = className
    }
    
    var body: some View {
        
//        var grouped: [Int: Int] = [:]
//        var groupedToArray: [Double] = []
        
        VStack {
            Button(action: {
                for (key, value) in growthViewModelData.groupedPositiveStudent where value == 0 {
                    growthViewModelData.groupedPositiveStudent.removeValue(forKey: key)
                }

                print("aaaaaaaa")
                print(growthViewModelData.groupedPositiveStudent.sorted {$0.1 > $1.1})
                print(growthViewModelData.groupedNegativeStudent.sorted {$0.1 > $1.1})
            }, label: {
                Text("Button")
            })
            
//            Text(uuid)
            Text(growthViewModelData.groupedToArrPositive.map { String($0) }.joined(separator: "-"))
            Text(growthViewModelData.groupedToArrNegative.map { String($0) }.joined(separator: "-"))
//            Text(growthViewModelData.groupedPositiveStudent)
            Button(action: { self.openChartView.toggle()}, label: {
                MultiLineChartView(data: [(growthViewModelData.groupedToArrPositive, GradientColors.blue), (growthViewModelData.groupedToArrNegative, GradientColors.orngPink)], title: "월별관찰")
            })

            Button(action: { self.openChartView.toggle()}, label: {
                BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "학생별", form: ChartForm.medium)
            })

            
        } // VStack
        .fullScreenCover(isPresented: $openChartView) {
            GrowthChartView()
        } // fullScreenCover
        .onAppear(perform: {
            growthViewModelData.fetchPositiveByMonth(uuid: uuid)
            growthViewModelData.fetchNegativeByMonth(uuid: uuid)
            growthViewModelData.fetchPositiveByStudent(uuid: uuid)
            growthViewModelData.fetchNegativeByStudent(uuid: uuid)
            
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
