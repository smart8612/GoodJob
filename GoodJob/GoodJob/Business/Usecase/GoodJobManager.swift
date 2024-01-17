//
//  GoodJobManager.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


final class GoodJobManager: NSObject, ObservableObject {
    
    private let persistenceController: PersistenceController
    
    private let jobPostingController: CDJobPostingFetchedResultsControlller
    
    init(persistenceController: PersistenceController = PersistenceController.shared) {
        self.persistenceController = persistenceController
        self.jobPostingController = CDJobPostingFetchedResultsControlller(
            managedObjectContext: persistenceController.managedObjectContext
        )
        super.init()
        jobPostingController.delegate = self
    }
    
    private var managedObectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    var jobPostings: [GJJobPosting] {
        jobPostingController.jobPostings
            .map {
                GJJobPosting(
                    id: $0.id ?? .init(),
                    companyName: $0.company?.name ?? .init(),
                    jobPostitionName: $0.positionName ?? .init(),
                    workplaceLocation: $0.workplaceLocation ?? .init(),
                    recruitNumbers: String(Int($0.recruitNumbers)),
                    link: $0.webLink?.absoluteString ?? .init(),
                    startDate: $0.startDate ?? .now,
                    endDate: $0.endDate ?? .now
                )
            }
    }
    
    func create(jobPosting: GJJobPosting) {
        let newCompany = CDCompany(context: managedObectContext)
        newCompany.id = UUID()
        newCompany.name = jobPosting.companyName
        
        let newJobPosting = CDJobPosting(context: managedObectContext)
        newJobPosting.company = newCompany
        
        newJobPosting.id = jobPosting.id
        newJobPosting.positionName = jobPosting.jobPostitionName
        newJobPosting.recruitNumbers = Int64(jobPosting.recruitNumbers) ?? 0
        newJobPosting.webLink = URL(string: jobPosting.link)
        
        newJobPosting.startDate = jobPosting.startDate
        newJobPosting.endDate = jobPosting.endDate
        
        try? managedObectContext.save()
    }
    
    func deleteJobPostings(on offsets: IndexSet) {
        let postIds = offsets
            .compactMap { jobPostings[$0].id }
            .reduce(into: Set<UUID>()) { $0.insert($1) }
        
        jobPostingController.jobPostings
            .filter { postIds.contains($0.id ?? .init()) }
            .forEach { managedObectContext.delete($0) }
    }
    
}


extension GoodJobManager: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
}
