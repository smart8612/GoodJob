//
//  GJAppCategory.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


enum GJAppCategory: String, Identifiable, Hashable, CaseIterable {
    
    // case summary
    case applications
    case jobs
    case menu
    
    var id: GJAppCategory { self }
    
    var name: String {
        NSLocalizedString(self.rawValue.capitalized, comment: .init())
    }
    
    var symboleName: String {
        switch self {
//        case .summary:
//            return "house.fill"
        case .applications:
            return "list.bullet.clipboard.fill"
        case .jobs:
            return "figure.run"
        case .menu:
            return "ellipsis"
        }
        
    }
    
    @ViewBuilder var contentView: some View {
        switch self {
//        case .summary:
//            SummaryView()
        case .applications:
            JobApplicationView()
        case .jobs:
            JobPostingsListView()
        case .menu:
            MenuView()
        }
    }
    
    static var allCategories: [Self] = Self.allCases
}
