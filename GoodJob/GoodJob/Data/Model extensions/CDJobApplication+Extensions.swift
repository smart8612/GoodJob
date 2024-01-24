//
//  CDJobApplication+Extensions.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/19/24.
//

import Foundation
import CoreData


extension CDJobApplication {
    
    public var id: UUID {
        get { id_ ?? .init() }
        set { id_ = newValue }
    }
    
    var createdAt: Date {
        get { createdAt_ ?? .now }
        set { createdAt_ = newValue }
    }
    
    var title: String {
        get { title_ ?? .init() }
        set { title_ = newValue }
    }
    
    var jobPosting: CDJobPosting {
        get { jobPosting_! }
        set { jobPosting_ = newValue }
    }
    
    var testRecords: Set<CDTestRecord> {
        get { testRecords_ as? Set<CDTestRecord> ?? .init() }
        set { testRecords_ = newValue as NSSet }
    }
    
    var user: CDUser {
        get { user_! }
        set { user_ = newValue }
    }
    
    convenience init(title: String, user: CDUser, jobPosting: CDJobPosting,
                     testRecords: Set<CDTestRecord>, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.user = user
        self.jobPosting = jobPosting
        self.testRecords = testRecords
    }
    
    public override func awakeFromInsert() {
        self.id = .init()
        self.createdAt = .now
    }
    
}


extension CDJobApplication {
    
    static func fetch(ids: [UUID], in context: NSManagedObjectContext) throws -> [CDJobApplication] {
        let fetchRequest = Self.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ IN %@", ids
        )
        
        let fetchedResults = try context.fetch(fetchRequest)
        return fetchedResults
    }
    
    static func delete(ids: [UUID], in context: NSManagedObjectContext) throws {
        try Self.fetch(ids: ids, in: context)
            .forEach { context.delete($0) }
        try context.save()
    }
    
}
