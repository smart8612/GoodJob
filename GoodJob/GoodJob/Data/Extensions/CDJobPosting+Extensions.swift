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
    }
    
}


extension CDJobPosting {
    
    static func fetch(ids: [UUID], in context: NSManagedObjectContext) throws -> [CDJobPosting] {
        let fetchRequest = Self.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id_ IN %@", ids)
        
        let fetchedResult = try context.fetch(fetchRequest)
        
        return fetchedResult
    }
    
    static func delete(ids: [UUID], in context: NSManagedObjectContext) throws {
        try Self.fetch(ids: ids, in: context)
            .forEach { context.delete($0) }
        try context.save()
    }
    
}
