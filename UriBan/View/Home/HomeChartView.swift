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
    // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
    @State var arrPositiveStudent: [(String,Int)] = []
    @State var arrNegativeStudent: [(String,Int)] = []
    
    init(uuid: String, className: String) {
        self.uuid = uuid
        self.className = className
    }
    
    var body: some View {
        
        VStack {
            Button(action: {
//                for (key, value) in growthViewModelData.groupedPositiveStudent where value == 0 {
//                    growthViewModelData.groupedPositiveStudent.remove(at: 1)
//                }

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

//            let chartStyle = ChartStyle(backgroundColor: Color.black, accentColor: Colors.OrangeStart, secondGradientColor: Colors.OrangeEnd, textColor: Color.white, legendTextColor: Color.white, dropShadowColor:Color.white)
            
            Button(action: { self.openChartView.toggle()}, label: {
                BarChartView(data: ChartData(values: arrPositiveStudent), title: "학생별(긍정)",  style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.blue, secondGradientColor: Color.blue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray))
            })
            
            Button(action: { self.openChartView.toggle()}, label: {
                BarChartView(data: ChartData(values: arrNegativeStudent), title: "학생별(부정)", form: ChartForm.extraLarge)
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
            // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
            self.arrPositiveStudent = growthViewModelData.groupedPositiveStudent.sorted {$0.1 > $1.1}
            self.arrNegativeStudent = growthViewModelData.groupedNegativeStudent.sorted {$0.1 > $1.1}
            
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
