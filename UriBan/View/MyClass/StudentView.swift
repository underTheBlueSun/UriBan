//
//  StudentView.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI

struct StudentView: View {
    
    var uuid: String
    var studentViewModelData: StudentViewModel
    


    
//    init(school: String) {
//        self.studentViewModelData = StudentViewModel(school: school)
//    }
    
    init(uuid: String) {
        self.uuid = uuid
        self.studentViewModelData = StudentViewModel(uuid: uuid)
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
