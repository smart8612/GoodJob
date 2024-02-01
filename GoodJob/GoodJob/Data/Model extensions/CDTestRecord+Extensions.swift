//
//  CDTestRecord+Extensions.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/19/24.
//

import Foundation
import CoreData


extension CDTestRecord {
    
    public var id: UUID {
        get { id_ ?? .init() }
        set { id_ = newValue }
    }
    
    var memo: String {
        get { memo_ ?? .init() }
        set { memo_ = newValue }
    }
    
    var jobApplication: CDJobApplication {
        get { jobApplication_! }
        set { jobApplication_ = newValue }
    }
    
    var test: CDTest {
        get { test_ ?? .init() }
        set { test_ = newValue }
    }
    
    var result: TestResult {
        get { TestResult(rawValue: Int(result_)) ?? .inProgress }
        set { result_ = Int64(newValue.rawValue) }
    }
    
    var createdAt: Date {
        get { createdAt_! }
        set { createdAt_ = newValue }
    }
    
    convenience init(result: TestResult, memo: String, jobApplication: CDJobApplication, test: CDTest,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.result = result
        self.memo = memo
        self.jobApplication = jobApplication
        self.test = test
    }
    
    public override func awakeFromInsert() {
        self.id = .init()
        self.createdAt = .now
    }
    
    enum TestResult: Int {
        case inProgress = 0
        case pass
        case fail
    }
    
}
