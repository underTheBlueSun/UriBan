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
        
        ScrollView {
            Button(action: {
                print(growthViewModelData.groupedPositive.sorted(by: <))
                print(growthViewModelData.groupedNegative.sorted(by: <))
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

            
        } // VStack
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
