//
//  Category.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI

enum Category: String, Identifiable, Hashable, CaseIterable {
    
    case summary
    case applications
    case jobs
    
    var id: Category { self }
    
    var name: String {
        self.rawValue.capitalized
    }
    
    var symboleName: String {
        switch self {
        case .summary:
            return "house.fill"
        case .applications:
            return "list.bullet.clipboard.fill"
        case .jobs:
            return "figure.run"
        }
        
    }
    
    static var allCategories: [Self] = Self.allCases
}
