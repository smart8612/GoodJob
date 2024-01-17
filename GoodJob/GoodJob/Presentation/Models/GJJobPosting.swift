//
//  GJJobPosting.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation


struct GJJobPosting: Identifiable {
    
    var id: UUID = UUID()
    
    var companyName: String
    var jobPostitionName: String
    var workplaceLocation: String
    var recruitNumbers: String
    var link: String
    
    var startDate: Date
    var endDate: Date
    
    static func initWithEmpty() -> Self {
        Self(
            companyName: .init(),
            jobPostitionName: .init(),
            workplaceLocation: .init(),
            recruitNumbers: .init(),
            link: .init(),
            startDate: .now,
            endDate: .now
        )
    }
    
}
