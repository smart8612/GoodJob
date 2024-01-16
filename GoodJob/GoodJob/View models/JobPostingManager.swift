//
//  JobPostingManager.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/16/24.
//

import Foundation
import CoreData


final class JobPostingManager: ObservableObject {
    
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController = PersistenceController.shared) {
        self.persistenceController = persistenceController
    }
    
    private var managedObjectContext: NSManagedObjectContext {
        PersistenceController.shared.managedObjectContext
    }
    
    func createJobPosting(with handler: (JobPosting) -> Void) {
        let newJobPosting = JobPosting(context: managedObjectContext)
        newJobPosting.company = Company(context: managedObjectContext)
        handler(newJobPosting)
        save()
    }
    
    func update(jobPosting: JobPosting) {
        save()
    }
    
    func delete(jobPosting: JobPosting) {
        save()
    }
    
    private func save() {
        do {
            try managedObjectContext.save()
        } catch {
            managedObjectContext.rollback()
            
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
