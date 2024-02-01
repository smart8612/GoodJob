//
//  GJTestDataObserver.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/30/24.
//

import Foundation
import CoreData


final class GJTestDataObserver: NSObject, GJDataObserver {
    
    weak var delegate: GJDataObserverDelegate?
    
    private let persistenceController: PersistenceController
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    private lazy var fetchedResultController: NSFetchedResultsController<CDTest>? = {
        let fetchRequest = CDTest.fetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "order_", ascending: true)
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

extension GJTestDataObserver: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataWillChange()
    }
    
}
