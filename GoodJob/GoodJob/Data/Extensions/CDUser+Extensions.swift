//
//  CDUser+Extensions.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/19/24.
//

import Foundation
import CoreData


extension CDUser {
    
    public var id: UUID {
        get { id_ ?? .init() }
        set { id_ = newValue }
    }
    
    var name: String {
        get { name_ ?? .init() }
        set { name_ = newValue }
    }
    
    var jobApplications: Set<CDJobApplication> {
        get { jobApplications_ as? Set<CDJobApplication> ?? .init() }
        set { jobApplications_ = newValue as NSSet }
    }
    
    convenience init(name: String, jobApplications: Set<CDJobApplication>,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.jobApplications = jobApplications
    }
    
    public override func awakeFromInsert() {
        self.id = .init()
    }
    
}
