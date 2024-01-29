//
//  GJRepository.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/23/24.
//

import Foundation


protocol GJRepository<Entity> {
    
    associatedtype Entity: Identifiable
    
    func fetchAll() throws -> [Entity]
    func fetch(objectsWith ids: [UUID]) throws -> [Entity]
    
    @discardableResult
    func create(object: Entity) throws -> Entity
    
    @discardableResult
    func update(objectWith id: UUID, to object: Entity) throws -> Entity
    
    func delete(objectWith id: UUID) throws
    
}
