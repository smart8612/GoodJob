//
//  GJTestRecordDataObserver.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/29/24.
//

import Foundation
import CoreData


final class GJTestRecordDataObserver: NSObject, GJDataObserver {
    
    weak var delegate: GJDataObserverDelegate?
    
    private let persistenceController: PersistenceController
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    private lazy var fetchedResultController: NSFetchedResultsController<CDTestRecord>? = {
        let fetchRequest = CDTestRecord.fetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "createdAt_", ascending: false)
        ]
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
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

extension GJTestRecordDataObserver: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataWillChange()
    }
    
}
