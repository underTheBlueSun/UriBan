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
    
    @State private var selectedSubject: Bool = false
    @State private var selectedSheet: Bool = false
    
    private func getDate(format: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: format)
        return current_date_string
    }
    
    func getPercent(current: CGFloat, goal: CGFloat) -> String {
        let per = (current / goal) * 100
        return String(format: "%.1f", per)
    }
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                // Hstack에서 버튼 액션은 연달아 먹힘. 그래서 onTapGesture 사용
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                    .onTapGesture {
                        self.selectedSubject = true
                        self.selectedSheet = false
                        subjectViewModelData.fetchData(uuid: homeViewModelData.uribanID)
                    }
                    Button(action: {}, label: {
                        Text("과제").foregroundColor(selectedSubject == true ? .systemTeal : .gray).font(.system(size: 15))
                        
                    } )
                    .onTapGesture {
                        self.selectedSubject = true
                        self.selectedSheet = false
                        subjectViewModelData.fetchSubject(uuid: homeViewModelData.uribanID)
                    }
                                        
                    Button(action: {}, label: {
                            Text("안내장").foregroundColor(selectedSheet == true ? .systemTeal : .gray).font(.system(size: 15))
                        
                    } )
                    .onTapGesture {
                        self.selectedSubject = false
                        self.selectedSheet = true
                        subjectViewModelData.fetchSheet(uuid: homeViewModelData.uribanID)
                    }
                    .padding(.horizontal)

                }

                
                ForEach(subjectViewModelData.subjects) { subject in
                    NavigationLink(destination:
                                    DetailSubjectView(subject: subject)
                                    .environmentObject(homeViewModelData)
                                    .environmentObject(studentViewModelData)
                                    .environmentObject(subjectViewModelData)) {
                        HStack {
                            Text(subject.content).frame(width: 250, height: 20, alignment: .leading).font(.system(size: 15))
                            VStack {
                                Text(getDate(format: subject.yymmdd)).frame(alignment: .trailing)
                                    .frame(alignment: .trailing)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                                Spacer()
                                Text(getPercent(current: CGFloat(subject.count), goal: CGFloat(studentViewModelData.students.count)) + "%")
                                    .frame(alignment: .trailing)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                            }

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
                        if studentViewModelData.students.count != 0 { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) }
                    })
                } // ToolbarItem
            } // toolbar
            
        } // NavigationView
//        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $subjectViewModelData.openNewPage) {
            AddSubjectView()
                .environmentObject(studentViewModelData)
                .environmentObject(subjectViewModelData)
                .environmentObject(homeViewModelData)
        }
        .onAppear() {
            subjectViewModelData.fetchData(uuid: homeViewModelData.uribanID)
        }
        .navigationViewStyle(StackNavigationViewStyle())

        
   } // body
}

//struct SubjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubjectView().environmentObject(HomeViewModel())
//    }
//}

