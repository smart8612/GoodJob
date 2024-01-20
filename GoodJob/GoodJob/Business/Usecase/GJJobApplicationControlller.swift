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
    
    var jobApplications: [CDJobApplication] {
        controller.fetchedObjects ?? []
    }
    
}
