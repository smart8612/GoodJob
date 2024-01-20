//
//  CDJobPostingFetchedResultsControlller.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


final class CDJobApplicationFetchedResultsControlller: NSObject, ObservableObject {
    
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

// MARK: 키패스 문법으로 고치기
final class CDJobPostingFetchedResultsControlller: NSObject, ObservableObject {
    
    private let controller: NSFetchedResultsController<CDJobPosting>
    
    var delegate: NSFetchedResultsControllerDelegate? {
        get { controller.delegate }
        set { controller.delegate = newValue }
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        let fetchRequest = CDJobPosting.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "createdAt_", ascending: false)
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
