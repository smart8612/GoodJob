//
//  JobPostingCellView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/16/24.
//

import SwiftUI


struct JobPostingCellView: View {
    
    let jobPosting: GJJobPosting
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            HStack {
                Text(jobPosting.jobPostitionName)
            }
            Spacer()
            HStack(alignment: .center) {
                Label(jobPosting.companyName, systemImage: "building")
                Divider()
                Label(jobPosting.endDate.formatted(), systemImage: "calendar")
            }
            Spacer()
        }
    }
}
