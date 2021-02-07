//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/07.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
//        Image(uiImage: (pictureImg ?? UIImage(systemName: "pencil")!))
        Image(uiImage: UIImage(imageLiteralResourceName: "profile02"))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
