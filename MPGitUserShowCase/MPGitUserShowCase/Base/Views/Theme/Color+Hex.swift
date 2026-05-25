//
//  Color+Hex.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 26.05.26.
//

import SwiftUI

extension Color {
    init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xff) / 255
        let g = Double((int >> 8) & 0xff) / 255
        let b = Double(int & 0xff) / 255
        self.init(red: r, green: g, blue: b)
    }

    // MARK: - App Theme Colors
    static let oceanDeep    = Color("141e30")   // deep navy
    static let oceanMid     = Color("243b55")   // mid navy
}
