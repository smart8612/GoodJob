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
    
    @Published private(set) var jobPosting: GJJobPosting?
    @Published private(set) var tests: [GJTest]?
    
    func fetchJobPosting(with id: UUID) {
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
