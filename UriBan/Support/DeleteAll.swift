//
//  DeleteAll.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/19.
//

import SwiftUI
import RealmSwift

struct DeleteAll: View {
    var body: some View {
        VStack {
            
            Button(action: {
                guard let dbRef = try? Realm() else { return }
                try! dbRef.write {
                    dbRef.deleteAll()
                }

                
                
            }, label: {Text("Realm 데이터 모두 삭제")})
        }
    }
}

struct DeleteAll_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAll()
    }
}
