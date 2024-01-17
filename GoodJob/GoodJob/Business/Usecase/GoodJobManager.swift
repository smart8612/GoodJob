//
//  GoodJobManager.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


final class GoodJobManager: ObservableObject {
    
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController = PersistenceController.shared) {
        self.persistenceController = persistenceController
    }
    
    private var managedObectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    var jobPostings: [GJJobPosting] {
        return []
    }
    
    func create(jobPosting: GJJobPosting) {
        let newCompany = CDCompany(context: managedObectContext)
        newCompany.name = jobPosting.companyName
        
        let newJobPosting = CDJobPosting(context: managedObectContext)
        newJobPosting.company = newCompany
        
        newJobPosting.positionName = jobPosting.jobPostitionName
        newJobPosting.recruitNumbers = Int64(jobPosting.recruitNumbers) ?? 0
        newJobPosting.webLink = URL(string: jobPosting.link)
        
        newJobPosting.startDate = jobPosting.startDate
        newJobPosting.endDate = jobPosting.endDate
        
        try? managedObectContext.save()
    }
    
}
