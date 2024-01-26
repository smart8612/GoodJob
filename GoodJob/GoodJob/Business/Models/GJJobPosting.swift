//
//  GJJobPosting.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation


struct GJJobPosting: Identifiable, Hashable {
    
    var id: UUID = UUID()
    var link: String
    var createdAt: Date = .now
    
    var companyName: String
    
    var jobPositionName: String
    var workplaceLocation: String
    var recruitNumbers: String
    var startDate: Date
    var endDate: Date
    
    var testIds: Set<UUID>
    var jobApplicationId: UUID?
    
    static func initWithEmpty() -> Self {
        Self(
            id: .init(),
            link: .init(),
            createdAt: .init(),
            companyName: .init(),
            jobPositionName: .init(),
            workplaceLocation: .init(),
            recruitNumbers: .init(),
            startDate: .init(),
            endDate: .init(),
            testIds: .init()
        )
    }
    
}
