//
//  GJJobPositngDataObserver.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation
import CoreData


final class GJJobPositngDataObserver: NSObject, GJDataObserver {
    
    weak var delegate: GJDataObserverDelegate?
    
    private let persistenceController: PersistenceController
    
    private lazy var fetchedResultController: NSFetchedResultsController<CDJobPosting>? = {
        let fetchRequest = CDJobPosting.fetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "createdAt_", ascending: false)
        ]
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.persistenceController.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        try? controller.performFetch()
        return controller
    }()
    
    init(delegate: GJDataObserverDelegate? = nil, persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
        super.init()
        self.delegate = delegate
        self.fetchedResultController?.delegate = self
    }
    
}

extension GJJobPositngDataObserver: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataWillChange()
    }
    
}
