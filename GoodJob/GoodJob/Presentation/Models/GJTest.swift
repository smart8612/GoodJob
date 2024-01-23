//
//  GJTest.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/18/24.
//

import Foundation


struct GJTest: Identifiable, Hashable {
    
    var id: UUID = UUID()
    
    var name: String
    var type: TestType
    
    var jobPosting: GJJobPosting
    var testRecord: GJTestRecord?
    
    enum TestType: Int, Identifiable, CaseIterable, CustomStringConvertible {
        
        case writtenTest = 0
        case inteview
        
        var id: Self {
            self
        }
        
        var description: String {
            switch self {
            case .writtenTest:
                return "writtenTest"
            case .inteview:
                return "interview"
            }
        }
    }
    
    static func initWithEmpty() -> Self {
        Self(
            name: .init(),
            type: .writtenTest,
            jobPosting: .initWithEmpty(),
            testRecord: nil
        )
    }
    
}
