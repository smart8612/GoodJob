//
//  JobApplicationCellView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/21/24.
//

import SwiftUI


struct JobApplicationCellView: View {
    
    let jobApplication: GJJobApplication
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(jobApplication.title)
            Text(jobApplication.id.uuidString)
        }
    }
}
