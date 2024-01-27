//
//  GJJobApplicationDetailViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/26/24.
//

import Foundation


final class GJJobApplicationDetailViewModel: ObservableObject {
    
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
            testRepository: GJTestRepository())
    }()
    
    @Published private(set) var jobApplication: GJJobApplication?
    @Published private(set) var jobPosting: GJJobPosting?
    @Published private(set) var tests: [GJTest]?
    
    private let jobApplicationObserver: GJDataObserver
    private let jobPostingObserver: GJDataObserver
    
    var selectedJobApplicationId: UUID? {
        didSet { fetchJobApplication() }
    }
    
    init() {
        jobApplicationObserver = GJJobApplicationDataObserver()
        jobPostingObserver = GJJobPositngDataObserver()
        jobApplicationObserver.delegate = self
        jobPostingObserver.delegate = self
    }
    
    private func fetchJobApplication() {
        guard let id = selectedJobApplicationId else {
            return
        }
        
        do {
            let fetchedJobApplication = try jobApplicationController.fetchJobApplication(with: id)
            self.jobApplication = fetchedJobApplication
            
            let fetchedJobPosting = try jobPostingController.fetchJobPosting(with: fetchedJobApplication.jobPostingId)
            self.jobPosting = fetchedJobPosting
            
            let fetchedTests = try jobPostingController.fetchTests(belongsToJobPosting: fetchedJobPosting.id)
            self.tests = fetchedTests
        } catch {
            print(error)
        }
    }
    
}

extension GJJobApplicationDetailViewModel: GJDataObserverDelegate {
    
    func dataWillChange() {
        objectWillChange.send()
        fetchJobApplication()
    }
    
}
