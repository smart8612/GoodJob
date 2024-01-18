//
//  CDJobPosting+Extensions.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


extension CDJobPosting {
    
    public var id: UUID {
        get { id_ ?? .init() }
        set { id_ = newValue }
    }
    
    var company: CDCompany {
        get { company_! }
        set { company_ = newValue }
    }
    
    var positionName: String {
        get { positionName_ ?? .init() }
        set { positionName_ = newValue }
    }
    
    var workplaceLocation: String {
        get { workplaceLocation_ ?? .init() }
        set { workplaceLocation_ = newValue }
    }
    
    var recruitNumbers: Int {
        get { Int(recruitNumbers_) }
        set { recruitNumbers_ = Int64(newValue) }
    }
    
    var webLink: String {
        get { webLink_ ?? .init() }
        set { webLink_ = newValue }
    }
    
    var startDate: Date {
        get { startDate_ ?? .now }
        set { startDate_ = newValue }
    }
    
    var endDate: Date {
        get { endDate_ ?? .now }
        set { endDate_ = newValue }
    }
    
    var createdAt: Date {
        get { createdAt_ ?? .now }
        set { createdAt_ = newValue }
    }
    
    convenience init(company: CDCompany, positionName: String, workplaceLocation: String, recruitNumbers: Int, webLink: String, startDate: Date, endDate: Date, context: NSManagedObjectContext) {
        self.init(context: context)
        self.company = company
        self.positionName = positionName
        self.workplaceLocation = workplaceLocation
        self.recruitNumbers = recruitNumbers
        self.webLink = webLink
        self.startDate = startDate
        self.endDate = endDate
    }
    
    public override func awakeFromInsert() {
        self.id = UUID()
        self.createdAt = .now
    }
    
}
