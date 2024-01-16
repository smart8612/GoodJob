//
//  JobPostingCellView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/16/24.
//

import SwiftUI


struct JobPostingCellView: View {
    
    let jobPosting: JobPosting
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            HStack {
                Text(jobPosting.positionName ?? "")
            }
            Spacer()
            HStack(alignment: .center) {
                Label(jobPosting.company?.name ?? "", systemImage: "building")
                Divider()
                Label(jobPosting.endDate?.formatted() ?? "", systemImage: "calendar")
            }
            Spacer()
        }
    }
}
