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
    
    func getPercent(current: CGFloat, goal: CGFloat) -> String {
        let per = (current / goal) * 100
        return String(format: "%.1f", per)
    }
    
    var body: some View {
        
        ScrollView {
//            Button(action: {
//                print(growthViewModelData.groupedPositive.sorted(by: <))
//                print(growthViewModelData.groupedNegative.sorted(by: <))
//            }, label: {
//                Text("Button")
//            })

//            Text(growthViewModelData.groupedToArrPositive.map { String($0) }.joined(separator: "-"))
//            Text(growthViewModelData.groupedToArrNegative.map { String($0) }.joined(separator: "-"))
//            Text(growthViewModelData.groupedPositiveStudent)
            
            VStack {
                HStack {
                    // 월별 관찰 차트
                    Button(action: { self.openChartView.toggle()}, label: {
                        MultiLineChartView(data: [(growthViewModelData.groupedToArrPositive, GradientColors.blue), (growthViewModelData.groupedToArrNegative, GradientColors.orngPink)], title: "월별관찰현황",  form: ChartForm.medium)
                    })
                    
                    BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "월별상담현황", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.blue, secondGradientColor: Color.blue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                } // Hstack
                .padding()
                
//                VStack {
//                    LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", legend: "Legendary", form: ChartForm.small) // legend is optional
//                }
                
                
                // 과제 달성율 차트
                VStack {
                    Text("과제달성율").bold().font(.system(size: 30))
                    Text("터치하여 월별통계보기").font(.system(size: 10)).foregroundColor(Color.gray)
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 1 )
                            .stroke(Color.red.opacity(0.07), lineWidth: 10)
                            .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 300 / 2))

                        Circle()
                            .trim(from: 0, to: ( 10 / 24) )
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 300 / 2))

                        Text(getPercent(current: 10, goal: 24) + "%")
                            .font(.system(size: 22))
                            .rotationEffect(.init(degrees: 90))

                    } // ZStack
                    .rotationEffect(.init(degrees: -90))
                } // VStack
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.gray.opacity(0.5), radius: 10)
                

            } // Vsatack

        } // ScrollView
        .fullScreenCover(isPresented: $openChartView) {
            GrowthChartView(uuid: self.uuid, className: self.className)
        } // fullScreenCover
        .onAppear(perform: {
            growthViewModelData.fetchPositiveByMonth(uuid: uuid)
            growthViewModelData.fetchNegativeByMonth(uuid: uuid)
        }) // onAppear()
        
    } // body
}

struct HomeChartView_Previews: PreviewProvider {
    static var previews: some View {
        HomeChartView(uuid: "3457F0C5-4517-48DD-8689-990BACF4E455", className: "5-2반")
    }
}
