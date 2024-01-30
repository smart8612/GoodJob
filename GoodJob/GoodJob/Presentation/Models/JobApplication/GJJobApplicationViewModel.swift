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
    
    private let jobPostingController: GJJobPostingController = {
        GJJobPostingController(
            jobPostingRepository: GJJobPostingRepository(),
            testRepository: GJTestRepository()
        )
    }()
    
    private let jobApplicationObserver: any GJDataObserver
    private let jobPostingObserver: any GJDataObserver
    
    init() {
        self.jobPostingObserver = GJJobPositngDataObserver()
        self.jobApplicationObserver = GJJobApplicationDataObserver()
        self.jobApplicationObserver.delegate = self
        self.jobPostingObserver.delegate = self
    }
    
    func fetchJobApplication() {
        do {
            self.jobApplications = try jobApplicationController.fetchAllJobApplications()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchJobPosting(associatedWith jobApplication: GJJobApplication) -> GJJobPosting? {
        do {
            let jobPosting = try jobPostingController.fetchJobPosting(with: jobApplication.jobPostingId)
            return jobPosting
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func deleteJobApplication(at indexSet: IndexSet) {
        do {
            try indexSet
                .compactMap { jobApplications[$0] }
                .forEach { try jobApplicationController.delete(jobApplication: $0) }
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
