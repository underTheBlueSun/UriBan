//
//  GrowthChartStu.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/23.
//

import SwiftUI

import SwiftUI
import SwiftUICharts

struct GrowthChartStu: View {
    
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @Environment(\.presentationMode) var presentation
    
    // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
    @State var arrPositiveStudent: [(String,Int)] = []
    @State var arrNegativeStudent: [(String,Int)] = []
    
    var uuid: String
    var number: Int
    
    init(uuid: String, number: Int) {
        self.uuid = uuid
        self.number = number
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    BarChartView(data: ChartData(values: arrPositiveStudent), title: "학생별(긍정)",  style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.blue, secondGradientColor: Color.blue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                    
                    BarChartView(data: ChartData(values: arrNegativeStudent), title: "학생별(부정)", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.red, secondGradientColor: Color.red, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                } // HStack
                .padding()
                
                Divider()
                
                List {
                    HStack {
                        Text("날짜")
                        Spacer()
                        Text("인원수")
                        Spacer()
                        Text("상태")
                    } // HStack
                    .font(.system(size: 15))
                    .padding(.horizontal)
                    .background(Color.systemGray.opacity(0.2))
                                        
                    ForEach(growthViewModelData.groupedPositive.sorted(by: <), id: \.key) { key, value in
                        HStack {
                            Text(String(key) + "월")
                            Spacer()
                            Text(String(value) + "명")
                            Spacer()
                            Text("긍정").foregroundColor(Color.blue)
                        } // HStack
                        .padding(.horizontal)
                        .font(.system(size: 15))
                    } // ForEach
                } // List
                .environment(\.defaultMinListRowHeight, 5)
                
                Divider()
                
                List {
                    HStack {
                        // .font(.system(size: 15))
                        Text("날짜")
                        Spacer()
                        Text("인원수")
                        Spacer()
                        Text("상태")
                    } // HStack
                    .font(.system(size: 15))
                    .padding(.horizontal)
                    .background(Color.systemGray.opacity(0.2))
                    
                    ForEach(growthViewModelData.groupedNegative.sorted(by: <), id: \.key) { key, value in
                        HStack {
                            Text(String(key) + "월")
                            Spacer()
                            Text(String(value) + "명")
                            Spacer()
                            Text("부정").foregroundColor(Color.red)
                        } // HStack
                        .font(.system(size: 15))
                        .padding(.horizontal)
                    } // ForEach
                } // List
                .environment(\.defaultMinListRowHeight, 5)
                
                Spacer()
                
                
            } // VStack
//            .padding()
            .navigationBarTitle("학생별 관찰 통계", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentation.wrappedValue.dismiss() }, label: { Text("닫기") })
                }
            } // toolbar
        } // NavigationView
        .onAppear(perform: {
            growthViewModelData.fetchPositiveByIndi(uuid: uuid, number: number)
            growthViewModelData.fetchNegativeByIndi(uuid: uuid, number: number)
            // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
            self.arrPositiveStudent = growthViewModelData.groupedPositiveStudent.sorted {$0.1 > $1.1}
            self.arrNegativeStudent = growthViewModelData.groupedNegativeStudent.sorted {$0.1 > $1.1}
//            print("번호: " + String(number))
//            print(arrPositiveStudent)
        }) // onAppear()

        
    }
}

//struct GrowthChartStu_Previews: PreviewProvider {
//    static var previews: some View {
//        GrowthChartStu()
//    }
//}
