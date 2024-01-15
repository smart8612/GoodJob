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
    case jobPostings
    
    var id: UUID {
        UUID()
    }
    
    var name: String {
        self.rawValue.capitalized
    }
    
    var symboleName: String {
        switch self {
        case .summary:
            return "house.fill"
        case .applications:
            return "list.bullet.clipboard.fill"
        case .jobPostings:
            return "figure.run"
        }
        
    }
}
