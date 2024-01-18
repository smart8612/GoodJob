//
//  GJJobPosting.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation


struct GJJobPosting: Identifiable, Hashable {
    
    var id: UUID = UUID()
    
    var companyName: String
    var jobPositionName: String
    var workplaceLocation: String
    var recruitNumbers: String
    var link: String
    
    var startDate: Date
    var endDate: Date
    
    var tests: [GJTest]
    
    static func initWithEmpty() -> Self {
        Self(
            companyName: .init(),
            jobPositionName: .init(),
            workplaceLocation: .init(),
            recruitNumbers: .init(),
            link: .init(),
            startDate: .now,
            endDate: .now,
            tests: .init()
        )
    }
    
}
