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
    @State var arrPositiveIndi: [(String,Int)] = []
    @State var arrNegativeIndi: [(String,Int)] = []
    
    var uuid: String
    var number: Int
    
    init(uuid: String, number: Int) {
        self.uuid = uuid
        self.number = number
    }
    
    // yyyy.mm.dd 가져오기
    private func getDate(format: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        let date = Date()
//        let today = dateFormatter.string(from: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: format)
//        print(current_date_string)
        return current_date_string
    }

    
    var body: some View {
        
//        NavigationView {
            VStack {
                HStack {
                    BarChartView(data: ChartData(values: arrPositiveIndi), title: "좋아요",  style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.blue, secondGradientColor: Color.blue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)

                    BarChartView(data: ChartData(values: arrNegativeIndi), title: "이건좀", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.red, secondGradientColor: Color.red, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                } // HStack
                .padding()
                
                Divider()
                
                List {
//                    HStack {
//                        Text("날짜")
//                        Spacer()
//                        Text("인원수")
//                        Spacer()
//                        Text("상태")
//                    } // HStack
//                    .font(.system(size: 15))
//                    .padding(.horizontal)
//                    .background(Color.systemGray.opacity(0.2))
                                        
//                    ForEach(growthViewModelData.groupedPositive.sorted(by: <), id: \.key) { key, value in
                    ForEach(growthViewModelData.growths) { growth in
                        HStack {
                            Text(growth.content).frame(width: 280, alignment: .leading).font(.system(size: 15))
                            VStack {
                                Text(getDate(format: growth.yymmdd)).frame(alignment: .trailing)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                                Spacer()
                                Text(growth.status).frame(alignment: .trailing)
                                    .foregroundColor(growth.status == "긍정" ? .blue : .red)
                                    .font(.system(size: 10))
                            }
                            
                        }
                        
                    } // ForEach
                } // List
//                .environment(\.defaultMinListRowHeight, 5)
                
//                Divider()
                
//                List {
//                    HStack {
//                        // .font(.system(size: 15))
//                        Text("날짜")
//                        Spacer()
//                        Text("인원수")
//                        Spacer()
//                        Text("상태")
//                    } // HStack
//                    .font(.system(size: 15))
//                    .padding(.horizontal)
//                    .background(Color.systemGray.opacity(0.2))
//
//                    ForEach(growthViewModelData.groupedNegative.sorted(by: <), id: \.key) { key, value in
//                        HStack {
//                            Text(String(key) + "월")
//                            Spacer()
//                            Text(String(value) + "명")
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
            .navigationBarTitle("학생별 관찰 통계", displayMode: .inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: { presentation.wrappedValue.dismiss() }, label: { Text("닫기") })
//                }
//            } // toolbar
//        } // NavigationView
        .onAppear(perform: {
            growthViewModelData.fetchPositiveByIndi(uuid: uuid, number: number)
            growthViewModelData.fetchNegativeByIndi(uuid: uuid, number: number)
            growthViewModelData.fetchDataStu(uuid: uuid, number: number)
            // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
            self.arrPositiveIndi = growthViewModelData.groupedPosiIndi.sorted(by: <).map { (String($0)+"월", Int($1)) }
            self.arrNegativeIndi = growthViewModelData.groupedNegaIndi.sorted(by: <).map { (String($0)+"월", Int($1)) }

//            }
            
        }) // onAppear()
        .onDisappear(perform: {
            presentation.wrappedValue.dismiss()
        })

        
    }
}

//struct GrowthChartStu_Previews: PreviewProvider {
//    static var previews: some View {
//        GrowthChartStu()
//    }
//}
