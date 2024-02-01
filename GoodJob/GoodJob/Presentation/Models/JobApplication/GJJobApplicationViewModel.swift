//
//  GJJobApplicationViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation


final class GJJobApplicationViewModel: ObservableObject {
    
    @Published var jobApplications: [GJJobApplication] = .init()
    private var jobAppicationsWithJobPosting: [GJJobApplication: GJJobPosting] = .init()
    
    @Published var searchText: String = .init()
    
    var filteredJobApplications: [GJJobApplication] {
        guard !searchText.isEmpty else { return jobApplications }
        return jobApplications.filter {
            guard let jobPosting = jobAppicationsWithJobPosting[$0] else { return false }
            return $0.title.localizedCaseInsensitiveContains(searchText) ||
            jobPosting.companyName.localizedCaseInsensitiveContains(searchText) ||
            jobPosting.jobPositionName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
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
    
    private let jobApplicationObserver = GJJobPositngDataObserver()
    private let jobPostingObserver = GJJobApplicationDataObserver()
    
    init() {
        self.jobApplicationObserver.delegate = self
        self.jobPostingObserver.delegate = self
        fetchJobApplication()
    }
    
    func fetchJobApplication() {
        do {
            self.jobApplications = try jobApplicationController.fetchAllJobApplications()
            self.jobAppicationsWithJobPosting = try self.jobApplications.reduce(into: [GJJobApplication: GJJobPosting]()) { prev, next in
                prev[next] = try jobPostingController.fetchJobPosting(with: next.jobPostingId)
            }
            
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
