//
//  GJNewJobPostingViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation


final class GJNewJobPostingViewModel: ObservableObject {
    
    @Published var newJobPosting = GJJobPosting.initWithEmpty()
    @Published var newTests: [GJTest] = .init()
    
    private let jobPostingController: GJJobPostingControlller = {
        let jobPostingRepository = GJJobPostingRepository()
        let testRepository = GJTestRepository()
        let jobPositngController = GJJobPostingControlller(
            jobPostingRepository: jobPostingRepository,
            testRepository: testRepository
        )
        return jobPositngController
    }()
    
    var enumeratedTests: [(Int, GJTest)] {
        Array(newTests.enumerated())
    }
    
    func createNewJobPosting() {
        do {
            let _ = try jobPostingController.create(
                jobPosting: newJobPosting,
                tests: makeOrderedTests()
            )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addEmptyTest() {
        let newTest = GJTest.initWithEmpty()
        newTests.append(newTest)
    }
    
    func changeTestType(to newTestType: GJTest.TestType, at index: Int) {
        newTests[index].type = newTestType
    }
    
    private func makeOrderedTests() -> [GJTest] {
        enumeratedTests.map { index, _ in
            var test = newTests[index]
            test.order = index
            return test
        }
    }
    
}
