//
//  SubjectView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/20.
//

import SwiftUI

struct SubjectView: View {
    
    @EnvironmentObject var studentViewModelData: StudentViewModel
//    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    @EnvironmentObject var subjectViewModelData: SubjectViewModel
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(subjectViewModelData.subjects) { subject in
                    NavigationLink(destination:
                                    DetailSubjectView(subject: subject)
                                    .environmentObject(homeViewModelData)
                                    .environmentObject(studentViewModelData)
                                    .environmentObject(subjectViewModelData)) {
                        HStack {
                            Text(subject.content).frame(width: 300, height: 15, alignment: .leading)
                        } // Hstack
                    } // NavigationLink
                } // ForEach
            } // List
            .background(Color.white)
            .navigationBarTitle(homeViewModelData.uribanClassName, displayMode: .inline)
            .navigationBarColor(backgroundColor: .systemTeal, tintColor: .white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        subjectViewModelData.openNewPage.toggle()
                    }, label: {
                        if homeViewModelData.uribanID != "" { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) }
                    })
                } // ToolbarItem
            } // toolbar
            
        } // NavigationView
        .fullScreenCover(isPresented: $subjectViewModelData.openNewPage) {
            AddSubjectView()
                .environmentObject(studentViewModelData)
                .environmentObject(subjectViewModelData)
                .environmentObject(homeViewModelData)
        }
        .onAppear() {
            subjectViewModelData.fetchData(uuid: homeViewModelData.uribanID)
        }

        
   } // body
}

//struct SubjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubjectView().environmentObject(HomeViewModel())
//    }
//}

