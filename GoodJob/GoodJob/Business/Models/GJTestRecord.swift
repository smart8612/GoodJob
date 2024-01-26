//
//  GJTestRecord.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/22/24.
//

import Foundation


struct GJTestRecord: Identifiable, Hashable {
    
    var id: UUID = UUID()
    
    var jobApplicationId: UUID
    var testId: UUID
    
    var memo: String
    
}
