//
//  Item.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 20.05.26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
