//
//  GJTestRecord.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/22/24.
//

import Foundation


struct GJTestRecord: Identifiable, Hashable {
    
    var id: UUID = UUID()
    var createdAt: Date = .now
    
    var jobApplicationId: UUID
    var testId: UUID
    
    var result: TestResult
    var memo: String
    
    static func initWithEmpty() -> Self {
        Self(jobApplicationId: .init(), testId: .init(), result: .inProgress, memo: .init())
    }
    
    enum TestResult: Int, Identifiable,CustomStringConvertible, CaseIterable {
        
        case inProgress = 0
        case pass
        case fail
        
        var id: Self {
            self
        }
        
        var description: String {
            switch self {
            case .inProgress:
                return "inProgress"
            case .pass:
                return "pass"
            case .fail:
                return "fail"
            }
        }
        
    }
    
}
