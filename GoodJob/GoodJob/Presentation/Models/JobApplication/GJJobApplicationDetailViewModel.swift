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
    
    var selectedJobApplicationId: UUID?
    
    init(selectedJobApplicationId: UUID? = nil) {
        self.selectedJobApplicationId = selectedJobApplicationId
        jobApplicationObserver = GJJobApplicationDataObserver()
        jobPostingObserver = GJJobPositngDataObserver()
        jobApplicationObserver.delegate = self
        jobPostingObserver.delegate = self
    }
    
    func fetchJobApplication() {
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
    
    func fetchTestRecord(belongsTo test: GJTest) -> GJTestRecord? {
        do {
            return try jobApplicationController.fetchTestRecord(belongsTo: test)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func create(testRecord: GJTestRecord, belongsTo test: GJTest) {
        guard let jobApplication = jobApplication else { return }
        
        do {
            let targetTestRecord = GJTestRecord(jobApplicationId: jobApplication.id, testId: test.id, memo: testRecord.memo)
            let result = try jobApplicationController.create(testRecord: targetTestRecord)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension GJJobApplicationDetailViewModel: GJDataObserverDelegate {
    
    func dataWillChange() {
        objectWillChange.send()
        fetchJobApplication()
    }
    
}
