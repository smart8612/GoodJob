//
//  GJJobApplicationControlller.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import Foundation
import CoreData


final class GJJobApplicationControlller: NSObject, ObservableObject {
    
    private let controller: NSFetchedResultsController<CDJobApplication>
    
    var delegate: NSFetchedResultsControllerDelegate? {
        get { controller.delegate }
        set { controller.delegate = newValue }
    }
    
    var managedObjectContext: NSManagedObjectContext {
        controller.managedObjectContext
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        let fetchRequest = CDJobApplication.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDJobApplication.createdAt_, ascending: false)
        ]
        
        controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        try? controller.performFetch()
        
        super.init()
    }
    
    var jobApplications: [GJJobApplication] {
        (controller.fetchedObjects ?? [])
            .map { $0.convertToGJJobApplication() }
    }
    
    func create(jobApplication: GJJobApplication, userId: UUID) -> GJJobApplication {
        
        try? managedObjectContext.save()
        
        return .initWithEmpty()
    }
    
    func fetchJobApplications(ids: [UUID]) -> [GJJobApplication] {
        guard let fetchedJobApplications = try? CDJobApplication.fetch(ids: ids, in: managedObjectContext) else {
            return []
        }
        
        let convertedJobApplications = fetchedJobApplications.map { $0.convertToGJJobApplication() }
        return convertedJobApplications
    }
    
}


fileprivate extension CDJobApplication {
    
    func convertToGJJobApplication() -> GJJobApplication {
        GJJobApplication(
            id: self.id,
            jobPostingId: self.jobPosting.id,
            title: self.title,
            createdAt: self.createdAt
        )
    }
    
}
