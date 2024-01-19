//
//  GJJobApplication.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/19/24.
//

import Foundation


struct GJJobApplication: Identifiable, Hashable {
    
    var id: UUID = UUID()
    
    var jobPostingId: UUID
    var userId: UUID
    
    var title: String
    var createdAt: Date = Date()
    
}
