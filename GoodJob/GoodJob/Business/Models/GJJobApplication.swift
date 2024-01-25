//
//  GJJobApplication.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/19/24.
//

import Foundation


struct GJJobApplication: Identifiable, Hashable {
    
    var id: UUID = UUID()
    var title: String
    var createdAt: Date = Date()
    
    var jobPostingId: UUID
    var userId: UUID
    
    var testRecords: Set<UUID> = .init()
    
    static func initWithEmpty() -> Self {
        Self.init(
            title: .init(),
            jobPostingId: .init(),
            userId: .init()
        )
    }
    
}
