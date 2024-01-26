//
//  GJTest.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/18/24.
//

import Foundation


struct GJTest: Identifiable, Hashable {
    
    var id: UUID = UUID()
    
    var order: Int
    var name: String
    var type: TestType
    
    var jobPostingId: UUID
    var testRecordId: UUID?
    
    enum TestType: Int, Identifiable, CaseIterable, CustomStringConvertible {
        
        case test = 0
        case writtenTest
        case inteview
        
        var id: Self {
            self
        }
        
        var description: String {
            switch self {
            case .test:
                return "test"
            case .writtenTest:
                return "writtenTest"
            case .inteview:
                return "interview"
            }
        }
    }
    
    static func initWithEmpty() -> Self {
        Self(
            id: .init(),
            order: .zero,
            name: .init(),
            type: .test,
            jobPostingId: .init()
        )
    }
    
}
