//
//  GJNavigationModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/22/24.
//

import SwiftUI
import Combine


final class GJNavigationModel: ObservableObject {
    
    @Published var selectedCategory: GJAppCategory? = .applications {
        didSet {
            selectedJobPosting = nil
            selectedJobApplication = nil
        }
    }
    
    @Published var selectedJobApplication: GJJobApplication? = nil
    @Published var selectedJobPosting: GJJobPosting? = nil
    @Published var columnVisibility: NavigationSplitViewVisibility = .all
    
}
