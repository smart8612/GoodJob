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
    
    var link: String {
        get { link_ ?? .init() }
        set { link_ = newValue }
    }
    
    var createdAt: Date {
        get { createdAt_ ?? .now }
        set { createdAt_ = newValue }
    }
    
    var company: CDCompany {
        get { company_! }
        set { company_ = newValue }
    }
    
    var jobPosition: CDJobPosition {
        get { jobPosition_! }
        set { jobPosition_ = newValue }
    }
    
    var tests: Set<CDTest> {
        get { tests_ as? Set<CDTest> ?? .init() }
        set { tests_ = newValue as NSSet }
    }
    
    var jobApplication: CDJobApplication? {
        get { jobApplication_ }
        set { jobApplication_ = newValue }
    }
    
    convenience init(link: String, company: CDCompany, jobPosition: CDJobPosition, tests: Set<CDTest>, context: NSManagedObjectContext) {
        self.init(context: context)
        self.link = link
        self.company = company
        self.jobPosition = jobPosition
        self.tests = tests
    }
    
    public override func awakeFromInsert() {
        self.id = UUID()
        self.createdAt = .now
        self.jobApplication = nil
    }
    
}
