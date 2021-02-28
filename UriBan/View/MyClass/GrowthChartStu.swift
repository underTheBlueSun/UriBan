//
//  GrowthChartStu.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/23.
//

import SwiftUI
import SwiftUICharts

struct GrowthChartStu: View {
    
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @Environment(\.presentationMode) var presentation
    
    // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
//    @State var arrPositiveIndi: [(String,Int)] = []
//    @State var arrNegativeIndi: [(String,Int)] = []
    // 화면이 작아서 스몰로 받을려고
    @State var arrPositiveIndi1: [Double] = []
    @State var arrNegativeIndi1: [Double] = []

    var uuid: String
    var number: Int
    var name: String
    
    init(uuid: String, number: Int, name: String) {
        self.uuid = uuid
        self.number = number
        self.name = name
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
//                    BarChartView(data: ChartData(values: arrPositiveIndi), title: "좋아요",  style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.blue, secondGradientColor: Color.blue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                    BarChartView(data: ChartData(points: arrPositiveIndi1), title: "좋아요",  style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.blue, secondGradientColor: Color.blue, textColor: Color.gray, legendTextColor: Color.gray, dropShadowColor: Color.gray), form: ChartForm.small)

//                    BarChartView(data: ChartData(values: arrNegativeIndi), title: "고쳐요", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.red, secondGradientColor: Color.red, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                    BarChartView(data: ChartData(points: arrNegativeIndi1), title: "고쳐요", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.red, secondGradientColor: Color.red, textColor: Color.gray, legendTextColor: Color.gray, dropShadowColor: Color.gray), form: ChartForm.small)
                } // HStack
                .padding()
                
//                Divider()
                
                List {
                    ForEach(growthViewModelData.growths) { growth in
                        HStack {
                            Text(growth.content).frame(width: 280, alignment: .leading).font(.system(size: 15))
                                .frame(minWidth: 0, maxWidth: 280, minHeight: 10, maxHeight: 100)
                            VStack(spacing:0) {
                                Text(getDate(format: growth.yymmdd)).frame(alignment: .trailing)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                                Spacer()
                                Text(growth.status).frame(alignment: .trailing)
                                    .foregroundColor(growth.status == "좋아요" ? .blue : .red)
                                    .font(.system(size: 10))
                            }
                            
                        }
                        
                    } // ForEach
                } // List
//                .environment(\.defaultMinListRowHeight, 5)

                
            } // VStack
            .navigationBarTitle(self.name, displayMode: .inline)
        .onAppear(perform: {
            growthViewModelData.fetchPositiveByIndi(uuid: uuid, number: number)
            growthViewModelData.fetchNegativeByIndi(uuid: uuid, number: number)
            growthViewModelData.fetchDataStu(uuid: uuid, number: number)
            // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
//            self.arrPositiveIndi = growthViewModelData.groupedPosiIndi.sorted(by: <).map { (String($0)+"월", Int($1)) }
//            self.arrNegativeIndi = growthViewModelData.groupedNegaIndi.sorted(by: <).map { (String($0)+"월", Int($1)) }
            self.arrPositiveIndi1 = growthViewModelData.groupedToArrPosiIndi
            self.arrNegativeIndi1 = growthViewModelData.groupedToArrNegaIndi
            
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
