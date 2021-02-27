//
//  ForYou.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/27.
//

import SwiftUI
import AVKit

struct ForYou: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @Environment(\.presentationMode) var presentation
    
    
    var body: some View {
       
        NavigationView {
            Text("사랑하는 은희, 예림, 민욱을 위해...").foregroundColor(.gray)
                .navigationBarTitle("^^;", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentation.wrappedValue.dismiss()
                        }, label: {
                            Text("취소")
                        })
                    }
                }
             
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            let sound = Bundle.main.path(forResource: "IfNotDream", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()
        }
        
       
    }

}

struct ForYou_Previews: PreviewProvider {
    static var previews: some View {
        ForYou()
    }
}
