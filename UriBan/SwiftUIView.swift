//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/21.
//

import SwiftUI
import SwiftUICharts

struct SwiftUIView: View {
    var body: some View {
//        BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "Sales", legend: "Quarterly", form: ChartForm.large)

        
        VStack {
            HStack {
                Text("111111")
            }
            
            HStack {
                Text("1111111")
            }
        }
        .padding()
        .background(Color.tabbarBackgroud)
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
