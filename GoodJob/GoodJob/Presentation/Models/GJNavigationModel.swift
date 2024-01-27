//
//  GJNavigationModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/22/24.
//

import SwiftUI
import Combine


final class GJNavigationModel: ObservableObject {
    
    @Published var selectedCategory: GJAppCategory = .applications  
        
}
