//
//  GJDataObserver.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation


protocol GJDataObserver: AnyObject {
    
    var delegate: GJDataObserverDelegate? { get set }
    
}


protocol GJDataObserverDelegate: AnyObject {
    
    func dataWillChange()
    
}
