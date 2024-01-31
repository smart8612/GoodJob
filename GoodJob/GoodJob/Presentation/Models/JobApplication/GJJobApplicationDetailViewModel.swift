//
//  GJJobApplicationDetailViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/26/24.
//

import Foundation


final class GJJobApplicationDetailViewModel: ObservableObject {
    
    private let selectedJobApplicationId: UUID
    
    @Published private(set) var jobApplication: GJJobApplication?
    @Published private(set) var jobPosting: GJJobPosting?
    @Published private(set) var tests: [GJTest]?
    @Published private(set) var testRecords: [GJTest:GJTestRecord?]?
    
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
    
    private let jobApplicationObserver = GJJobApplicationDataObserver()
    private let jobPostingObserver = GJJobPositngDataObserver()
    private let testObserver = GJTestDataObserver()
    
    init(selectedJobApplicationId: UUID) {
        self.selectedJobApplicationId = selectedJobApplicationId
        jobApplicationObserver.delegate = self
        jobPostingObserver.delegate = self
        testObserver.delegate = self
    }
    
    func fetchJobApplication() {
        let id = selectedJobApplicationId
        
        do {
            let fetchedJobApplication = try jobApplicationController.fetchJobApplication(with: id)
            self.jobApplication = fetchedJobApplication
            
            let fetchedJobPosting = try jobPostingController.fetchJobPosting(with: fetchedJobApplication.jobPostingId)
            self.jobPosting = fetchedJobPosting
            
            let fetchedTests = try jobPostingController.fetchTests(belongsToJobPosting: fetchedJobPosting.id)
            self.tests = fetchedTests
            self.testRecords = fetchedTests.reduce(into: [GJTest:GJTestRecord?]()) { prevDict, test in
                prevDict[test] = try? jobApplicationController.fetchTestRecord(belongsTo: test)
            }
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
            let targetTestRecord = GJTestRecord(jobApplicationId: jobApplication.id, testId: test.id, result: testRecord.result, memo: testRecord.memo)
            let result = try jobApplicationController.create(testRecord: targetTestRecord)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(testRecord: GJTestRecord) {
        do {
            try jobApplicationController.delete(testRecord: testRecord)
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
