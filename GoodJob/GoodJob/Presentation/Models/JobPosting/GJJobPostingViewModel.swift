//
//  GJJobPostingViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation


final class GJJobPostingViewModel: ObservableObject {
    
    @Published private(set) var jobPostings: [GJJobPosting] = .init()
    
    @Published var searchText: String = .init()
    
    var filteredJobPostings: [GJJobPosting] {
        guard !searchText.isEmpty else { return jobPostings }
        return jobPostings.filter {
            $0.companyName.localizedCaseInsensitiveContains(searchText) ||
            $0.jobPositionName.localizedCaseInsensitiveContains(searchText) ||
            $0.workplaceLocation.localizedStandardContains(searchText)
        }
    }
    
    private let jobPostingController: GJJobPostingController = {
        GJJobPostingController(
            jobPostingRepository: GJJobPostingRepository(),
            testRepository: GJTestRepository()
        )
    }()
    
    private let jobPostingObserver: any GJDataObserver
    
    init() {
        self.jobPostingObserver = GJJobPositngDataObserver()
        self.jobPostingObserver.delegate = self
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
                .compactMap { filteredJobPostings[$0].id }
                .forEach { try jobPostingController.deleteJobPosting(id: $0) }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


extension GJJobPostingViewModel: GJDataObserverDelegate {
    
    func dataWillChange() {
        self.objectWillChange.send()
        fetchJobPostings()
    }
    
}
