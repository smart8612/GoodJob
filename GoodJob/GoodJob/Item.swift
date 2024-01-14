//
//  Item.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/14/24.
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
