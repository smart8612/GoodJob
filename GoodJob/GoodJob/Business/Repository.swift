//
//  Repository.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/23/24.
//

import Foundation


protocol Repository {
    
    associatedtype Entity: Identifiable
    
    func fetchAll() throws -> [Entity]
    func fetch(objectsWith ids: [UUID]) throws -> [Entity]
    func create(object: Entity) throws -> Entity
    func update(objectWith id: UUID, to object: Entity) throws -> Entity
    func delete(objectWith id: UUID) throws
    
}
