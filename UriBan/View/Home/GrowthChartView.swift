//
//  GrowthChartView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/20.
//

import SwiftUI
import SwiftUICharts

struct GrowthChartView: View {
    
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @Environment(\.presentationMode) var presentation
    
    // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
    @State var arrPositiveStudent: [(String,Int)] = []
    @State var arrNegativeStudent: [(String,Int)] = []
    
    var uuid: String
    var className: String    
    
    init(uuid: String, className: String) {
        self.uuid = uuid
        self.className = className
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
                        Text("건수")
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
                            Text(String(value) + "건")
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
                        Text("건수")
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
                            Text(String(value) + "건")
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
            growthViewModelData.fetchPositiveByStudent(uuid: uuid)
            growthViewModelData.fetchNegativeByStudent(uuid: uuid)
            // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
            self.arrPositiveStudent = growthViewModelData.groupedPositiveStudent.sorted {$0.1 > $1.1}
            self.arrNegativeStudent = growthViewModelData.groupedNegativeStudent.sorted {$0.1 > $1.1}
        }) // onAppear()

        
    }
}

//struct GrowthChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        GrowthChartView()
//    }
//}
