//
//  CDTest+Extensions.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/18/24.
//

import Foundation
import CoreData


extension CDTest {
    
    public var id: UUID {
        get { id_ ?? .init() }
        set { id_ = newValue }
    }
    
    var name: String {
        get { name_ ?? .init() }
        set { name_ = newValue }
    }
    
    var testType: TestType {
        get { TestType(rawValue: Int(testType_))! }
        set { testType_ = Int64(newValue.rawValue) }
    }
    
    convenience init(name: String, testType: TestType, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.testType = testType
    }
    
    public override func awakeFromInsert() {
        self.id = UUID()
    }
    
    enum TestType: Int {
        case writtenTest = 0
        case interview
    }
    
}
