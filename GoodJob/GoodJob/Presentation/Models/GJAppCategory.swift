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
    
    var id: GJAppCategory { self }
    
    var name: String {
        self.rawValue.capitalized
    }
    
    var symboleName: String {
        switch self {
//        case .summary:
//            return "house.fill"
        case .applications:
            return "list.bullet.clipboard.fill"
        case .jobs:
            return "figure.run"
        }
        
    }
    
    @ViewBuilder var contentView: some View {
        switch self {
//        case .summary:
//            SummaryView()
        case .applications:
            JobApplicationsListView()
        case .jobs:
            JobPostingsListView()
        }
    }
    
    static var allCategories: [Self] = Self.allCases
}
