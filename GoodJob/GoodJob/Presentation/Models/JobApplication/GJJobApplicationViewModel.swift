//
//  GJJobApplicationViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation


final class GJJobApplicationViewModel: ObservableObject {
    
    @Published private(set) var jobApplications: [GJJobApplication] = .init()
    
    private let jobApplicationController: GJJobApplicationController = {
       GJJobApplicationController(
        testRecordRepository: GJTestRecordRepository(), 
        jobApplicationRepository: GJJobApplicationRepository(),
        jobPostingRepository: GJJobPostingRepository()
       )
    }()
    
    private let jobApplicationObserver: any GJDataObserver
    
    init() {
        self.jobApplicationObserver = GJJobApplicationDataObserver()
        self.jobApplicationObserver.delegate = self
        fetchJobApplication()
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
        fetchJobApplication()
    }
    
}
