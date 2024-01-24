//
//  CDJobPosition+Extensions.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/18/24.
//

import Foundation
import CoreData


extension CDJobPosition {
    
    public var id: UUID {
        get { id_ ?? .init() }
        set { id_ = newValue }
    }
    
    var name: String {
        get { name_ ?? .init() }
        set { name_ = newValue }
    }
    
    var workplaceLocation: String {
        get { workplaceLocation_ ?? .init() }
        set { workplaceLocation_ = newValue }
    }
    
    var recruitNumbers: Int {
        get { Int(recruitNumbers_) }
        set { recruitNumbers_ = Int64(newValue) }
    }
    
    var startDate: Date {
        get { startDate_ ?? .now }
        set { startDate_ = newValue }
    }
    
    var endDate: Date {
        get { endDate_ ?? .now }
        set { endDate_ = newValue }
    }
    
    convenience init(name: String, workplaceLocation: String, recruitNumbers: Int, startDate: Date, endDate: Date, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.workplaceLocation = workplaceLocation
        self.recruitNumbers = recruitNumbers
        self.startDate = startDate
        self.endDate = endDate
    }
    
    public override func awakeFromInsert() {
        self.id = .init()
    }
    
}
