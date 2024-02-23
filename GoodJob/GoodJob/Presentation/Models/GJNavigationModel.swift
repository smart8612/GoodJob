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
    @Published var jobApplicationPath = NavigationPath()
    @Published var jobPostingPath = NavigationPath()
    
    let categories = GJAppCategory.allCategories
    
    var tabSelection: Binding<GJAppCategory> {
        return .init {
            return self.selectedCategory
        } set: { newValue in
            if newValue == self.selectedCategory {
                self.popToRoot()
            }
            self.selectedCategory = newValue
        }
    }
    
    private func popToRoot() {
        switch selectedCategory {
        case .applications:
            jobApplicationPath.removeLast(jobApplicationPath.count)
        case .jobs:
            jobPostingPath.removeLast(jobPostingPath.count)
        case .menu:
            break
        }
    }
        
}
