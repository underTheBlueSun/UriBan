//
//  ToggleExam.swift
//  UriBan
//
//  Created by macbook on 2021/02/04.
//

import SwiftUI

struct ToggleExam: View {
    
    @State var tab = "남자"
    @Namespace var animation
    
 
    var body: some View {
        
        VStack {
            Spacer()
            TextField("",text: $tab)
            HStack(spacing: 0) {
                TabButton(selected: $tab, title: "남자", animation: animation, gubun: 1)
                TabButton(selected: $tab, title: "여자", animation: animation, gubun: 2)
            }
            .frame(width: 130)
            .background(Color.gray.opacity(0.08))
            .clipShape(Capsule())
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea(.all)
    }
}



struct ToggleExam_Previews: PreviewProvider {
    static var previews: some View {
        ToggleExam()
    }
}
