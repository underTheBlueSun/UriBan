//
//  SubjectChartView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/24.
//

import SwiftUI
import SwiftUICharts

struct SubjectChartView: View {
    
    @EnvironmentObject var subjectViewModelData: SubjectViewModel
    @EnvironmentObject var studentViewModelData: StudentViewModel
    
    @Environment(\.presentationMode) var presentation
    
    // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
    @State var countByStudent: [(String,Int)] = []
    
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
                    BarChartView(data: ChartData(values: countByStudent), title: "과제달성",  style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.blue, secondGradientColor: Color.blue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.extraLarge)
                    
//                    BarChartView(data: ChartData(values: arrNegativeStudent), title: "학생별(부정)", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.red, secondGradientColor: Color.red, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                } // HStack
                .padding()
                
                Divider()
                
                List {
//                    HStack {
//                        Text("날짜")
//                        Spacer()
//                        Text("건수")
//                        Spacer()
//                        Text("상태")
//                    } // HStack
//                    .font(.system(size: 15))
//                    .padding(.horizontal)
//                    .background(Color.systemGray.opacity(0.2))
                                        
                    ForEach(subjectViewModelData.cntByMonth.sorted(by: <), id: \.key) { key1, value1 in
                        HStack {
                            Text(String(key1) + "월")
                            Spacer()
                            Text(String(value1) + "건")
                            Spacer()
                            // 달성율 가져오기
                            ForEach(subjectViewModelData.achByMonth.sorted(by: <), id: \.key) { key2, value2 in
                                if key1 == key2 {
//                                    Text(String((value2 / (value1 * studentViewModelData.students.count))*100) + "%")
                                    let a: Double = Double(value1 * studentViewModelData.students.count)
                                    let b: Double = Double(value2) / a
                                    let c: Double = b * 100
                                    Text(String(format: "%.1f", c) + "%")
                                }
                            }
                            
                        } // HStack
                        .padding(.horizontal)
                        .font(.system(size: 15))
                    } // ForEach
                } // List
//                .environment(\.defaultMinListRowHeight, 5)
                
//                Divider()
//
//                List {
//                    HStack {
//                        Text("날짜")
//                        Spacer()
//                        Text("달성율")
//                        Spacer()
//                        Text("상태")
//                    } // HStack
//                    .font(.system(size: 15))
//                    .padding(.horizontal)
//                    .background(Color.systemGray.opacity(0.2))
//
//                    ForEach(subjectViewModelData.achByMonth.sorted(by: <), id: \.key) { key, value in
//                        HStack {
//                            Text(String(key) + "월")
//                            Spacer()
//                            Text(String(value) + "%")
//                            Spacer()
//                            Text("부정").foregroundColor(Color.red)
//                        } // HStack
//                        .font(.system(size: 15))
//                        .padding(.horizontal)
//                    } // ForEach
//                } // List
//                .environment(\.defaultMinListRowHeight, 5)
                
//                Spacer()
                
                
            } // VStack
//            .padding()
            .navigationBarTitle("과제 통계", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentation.wrappedValue.dismiss() }, label: { Text("닫기") })
                }
            } // toolbar
        } // NavigationView
        .onAppear(perform: {
            subjectViewModelData.fetchSubjectByStudent(uuid: uuid)
            // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
            self.countByStudent = subjectViewModelData.cntByStudent.sorted {$0.1 > $1.1}
            
            subjectViewModelData.fetchSubjectByMonth(uuid: uuid)
        }) // onAppear()

        
    }
}

//struct SubjectChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubjectChartView()
//    }
//}
