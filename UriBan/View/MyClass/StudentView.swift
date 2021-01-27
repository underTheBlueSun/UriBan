//
//  StudentView.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI

struct StudentView: View {
    

    var modelData: StudentViewModel

    
    init(school: String) {
        self.modelData = StudentViewModel(school: school)
    }
    
//    init(date: Date) {
//        self.modelData = StudentViewModel(date: date)
//    }
    
    
 
    var body: some View {
        NavigationView {
            Text("111" + modelData.date)
//            ForEach(modelData.students) { student in
//                Text(student.name)
//
//            } // ForEach
            
        } // LazyVGrid
        
    }
}

//struct StudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentView(home: Home02())
//    }
//}
