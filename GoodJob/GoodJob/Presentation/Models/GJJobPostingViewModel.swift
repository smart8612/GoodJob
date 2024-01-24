//
//  GJJobPostingViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation


final class GJJobPostingViewModel: ObservableObject {
    
    @Published private(set) var jobPostings: [GJJobPosting] = .init()
    
    private let jobPostingController: GJJobPostingControlller
    
    init() {
        let jobPostingRepository = GJJobPostingRepository()
        self.jobPostingController = GJJobPostingControlller(
            jobPostingRepository: jobPostingRepository
        )
        fetchJobPostings()
    }
    
    func fetchJobPostings() {
        do {
            self.jobPostings = try jobPostingController.fetchAllJobPostings()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteJobPostings(on offsets: IndexSet) {
        do {
            try offsets
                .compactMap { jobPostings[$0].id }
                .forEach { try jobPostingController.deleteJobPosting(id: $0) }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
