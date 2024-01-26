//
//  GJJobPostingDetailViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation


final class GJJobPostingDetailViewModel: ObservableObject {
    
    private let jobPostingController: GJJobPostingController = {
       GJJobPostingController(
        jobPostingRepository: GJJobPostingRepository(),
        testRepository: GJTestRepository()
       )
    }()
    
    private let jobPostingDataObserver = GJJobPositngDataObserver()
    
    var selectedJobPostingId: UUID? {
        didSet { fetchJobPosting() }
    }
    
    @Published private(set) var jobPosting: GJJobPosting?
    @Published private(set) var tests: [GJTest]?
    
    init(selectedJobPostingId: UUID? = nil, jobPosting: GJJobPosting? = nil, tests: [GJTest]? = nil) {
        self.selectedJobPostingId = selectedJobPostingId
        self.jobPosting = jobPosting
        self.tests = tests
        self.jobPostingDataObserver.delegate = self
    }
    
    func fetchJobPosting() {
        guard let id = selectedJobPostingId else {
            return
        }
        
        do {
            let fetchedJobPosting = try jobPostingController.fetchJobPosting(with: id)
            self.jobPosting = fetchedJobPosting
            let fetchedTests = try jobPostingController.fetchTests(belongsToJobPosting: id)
            self.tests = fetchedTests
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension GJJobPostingDetailViewModel: GJDataObserverDelegate {
    
    func dataWillChange() {
        self.objectWillChange.send()
        fetchJobPosting()
    }
    
}
