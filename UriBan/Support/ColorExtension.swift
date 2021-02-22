//
//  ColorExtension.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/30.
//

import SwiftUI
import UIKit

extension Color {
  static let peach = Color("peach")
  static let primaryShadow = Color.primary.opacity(0.2)
  static let secondaryText = Color(hex: "#6e6e6e")
  static let background = Color(UIColor.systemGray6)
  static let tabButtonRed = Color(hex: "#FF6559")
  static let tabbarBackgroud = Color(hex: "#58585D")
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {

    static var label: Color {
        return Color(UIColor.label)
    }

    static var secondaryLabel: Color {
        return Color(UIColor.secondaryLabel)
    }

    static var tertiaryLabel: Color {
        return Color(UIColor.tertiaryLabel)
    }

    static var quaternaryLabel: Color {
        return Color(UIColor.quaternaryLabel)
    }

    static var systemFill: Color {
        return Color(UIColor.systemFill)
    }

    static var secondarySystemFill: Color {
        return Color(UIColor.secondarySystemFill)
    }

    static var tertiarySystemFill: Color {
        return Color(UIColor.tertiarySystemFill)
    }

    static var quaternarySystemFill: Color {
        return Color(UIColor.quaternarySystemFill)
    }

    static var systemBackground: Color {
           return Color(UIColor.systemBackground)
    }

    static var secondarySystemBackground: Color {
        return Color(UIColor.secondarySystemBackground)
    }

    static var tertiarySystemBackground: Color {
        return Color(UIColor.tertiarySystemBackground)
    }

    static var systemGroupedBackground: Color {
        return Color(UIColor.systemGroupedBackground)
    }

    static var secondarySystemGroupedBackground: Color {
        return Color(UIColor.secondarySystemGroupedBackground)
    }

    static var tertiarySystemGroupedBackground: Color {
        return Color(UIColor.tertiarySystemGroupedBackground)
    }

    static var systemRed: Color {
        return Color(UIColor.systemRed)
    }

    static var systemBlue: Color {
        return Color(UIColor.systemBlue)
    }

    static var systemPink: Color {
        return Color(UIColor.systemPink)
    }

    static var systemTeal: Color {
        return Color(UIColor.systemTeal)
    }

    static var systemGreen: Color {
        return Color(UIColor.systemGreen)
    }

    static var systemIndigo: Color {
        return Color(UIColor.systemIndigo)
    }

    static var systemOrange: Color {
        return Color(UIColor.systemOrange)
    }

    static var systemPurple: Color {
        return Color(UIColor.systemPurple)
    }

    static var systemYellow: Color {
        return Color(UIColor.systemYellow)
    }

    static var systemGray: Color {
        return Color(UIColor.systemGray)
    }

    static var systemGray2: Color {
        return Color(UIColor.systemGray2)
    }

    static var systemGray3: Color {
        return Color(UIColor.systemGray3)
    }

    static var systemGray4: Color {
        return Color(UIColor.systemGray4)
    }

    static var systemGray5: Color {
        return Color(UIColor.systemGray5)
    }

    static var systemGray6: Color {
        return Color(UIColor.systemGray6)
    }
    
}
