//
//  GJUser.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/19/24.
//

import Foundation


struct GJUser: Identifiable, Hashable {
    
    var id: UUID = UUID()
    var name: String
    var jobApplicationIds: Set<UUID>
    
}
