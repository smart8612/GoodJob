//
//  CDCompany+Extensions.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


extension CDCompany {
    
    public var id: UUID {
        get { id_ ?? .init() }
        set { id_ = newValue }
    }
    
    var name: String {
        get { name_ ?? .init() }
        set { name_ = newValue }
    }
    
    var jobPostings: Set<CDJobPosting> {
        get { (jobPostings_ as? Set<CDJobPosting>) ?? .init() }
        set { jobPostings_ = newValue as NSSet }
    }
    
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
    }
    
    public override func awakeFromInsert() {
        self.id = UUID()
    }
    
}
