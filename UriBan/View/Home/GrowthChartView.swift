//
//  GrowthChartView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/20.
//

import SwiftUI

struct GrowthChartView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("aaaaaaa")
                
            }
            .padding()
            .navigationBarTitle("관찰 통계", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentation.wrappedValue.dismiss() }, label: { Text("닫기") })
                }
            } // toolbar
        } // NavigationView
        
    }
}

struct GrowthChartView_Previews: PreviewProvider {
    static var previews: some View {
        GrowthChartView()
    }
}
