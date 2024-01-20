//
//  GJJobPostingControlller.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


final class GJJobPostingControlller: NSObject, ObservableObject {
    
    private let controller: NSFetchedResultsController<CDJobPosting>
    
    var delegate: NSFetchedResultsControllerDelegate? {
        get { controller.delegate }
        set { controller.delegate = newValue }
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        let fetchRequest = CDJobPosting.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDJobPosting.createdAt_, ascending: false)
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
    
    var jobPostings: [CDJobPosting] {
        controller.fetchedObjects ?? []
    }
    
}
