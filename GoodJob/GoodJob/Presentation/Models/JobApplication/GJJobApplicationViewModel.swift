//
//  GJJobApplicationViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation


final class GJJobApplicationViewModel: ObservableObject {
    
    @Published private(set) var jobApplications: [GJJobApplication] = .init()
    
    private let jobApplicationController: GJJobApplicationControlller = {
       GJJobApplicationControlller(
        jobApplicationRepository: GJJobApplicationRepository()
       )
    }()
    
    private let jobApplicationObserver: any GJDataObserver
    
    init() {
        self.jobApplicationObserver = GJJobPositngDataObserver()
        self.jobApplicationObserver.delegate = self
    }
    
    private func fetchJobApplication() {
        do {
            self.jobApplications = try jobApplicationController.fetchAllJobApplications()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension GJJobApplicationViewModel: GJDataObserverDelegate {
    
    func dataWillChange() {
        self.objectWillChange.send()
    }
    
}
