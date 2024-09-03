//
//  Item.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
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
