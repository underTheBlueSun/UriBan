//
//  FirstResponderTextEditor.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/14.
//

import SwiftUI

struct FirstResponderTextEditor: UIViewRepresentable {
    
    @Binding var text: String
//    let placeholder: String
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        @Binding var text: String
        var becameFirstResponder = false
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textViewDidChangeSelection(_ textView: UITextView) {
            text = textView.text ?? ""
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let textView = UITextView()
        textView.delegate = context.coordinator
//        textView.placeholder = placeholder
        return textView
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
            
        }
    }
    
}
