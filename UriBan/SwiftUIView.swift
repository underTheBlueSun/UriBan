import SwiftUI

struct ContentView: View {
    @State var isActive : Bool = false

    var body: some View {
        NavigationView {
            NavigationLink(destination: ContentView2(rootIsActive: self.$isActive), isActive: self.$isActive) {
                Text("Hello, World!")
            }
//            .isDetailLink(false)
            .navigationBarTitle("Root")
        }
    }
}

struct ContentView2: View {
    @Binding var rootIsActive : Bool

    var body: some View {
        VStack {
            Button (action: { self.rootIsActive = false } ){
                Text("루트로 가즈k....")
            }
        }.navigationBarTitle("둘")
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
