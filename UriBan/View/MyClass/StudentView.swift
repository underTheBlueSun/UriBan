//
//  StudentView.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI

struct StudentView: View {
    
    var date: Date
    var studentViewModelData: StudentViewModel
    


    
//    init(school: String) {
//        self.studentViewModelData = StudentViewModel(school: school)
//    }
    
    init(date: Date) {
        self.date = date
        self.studentViewModelData = StudentViewModel(date: date)
    }
    
//    init() {
//        print("init")
//    }
    

    var body: some View {
            
        VStack {
            
            ScrollView {
    //                ForEach(studentViewModelData.students) { student in
    //                    Text(student.school)
    //
    //                } // ForEach
                    
            }
            
        } // VStack
//        .edgesIgnoringSafeArea(.top)
        .toolbar {
//            Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white)
            Button(action: {studentViewModelData.openNewPage.toggle()}) { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) }
        }
//            .onAppear(perform: {
//                print("onappear")
//            })

            
            

        
    }
}

//struct StudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentView(date: Date())
//    }
//}
