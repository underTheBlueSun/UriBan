//
//  SwiftUIView2.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/22.
//

import SwiftUI

struct SwiftUIView2: View {
    var body: some View {
        List{
            HStack {
                Text("aafdsfdsfds").frame(width: 280, alignment: .leading).font(.system(size: 15))
                VStack {
                    Text("2021.02.11")
                        .frame(alignment: .trailing)
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
//                        .padding(.bottom, 1)
                    Spacer()
                    if "010343".contains(String(format: "%02d", 01)) == true {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.green)
                            .font(.system(size: 12))
    //                                        .frame(width: 10, height: 10)
                    }
                }

            }
            
        }
//        .environment(\.defaultMinListRowHeight, 1)
        
        
        
    }
}

struct SwiftUIView2_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView2()
    }
}
