//
//  Repository.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/23/24.
//

import Foundation


protocol Repository {
    
    associatedtype Entity: Identifiable
    
    func fetch(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) throws -> [Entity]
    func create() throws -> Entity
    func update(objectWithId: UUID, to object: Entity) throws -> Entity
    func delete(objectWithId: UUID) throws
    
}
