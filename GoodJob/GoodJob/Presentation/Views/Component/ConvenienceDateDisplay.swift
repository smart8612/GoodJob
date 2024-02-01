//
//  ConvenienceDateDisplay.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/29/24.
//

import SwiftUI


struct ConvenienceDateDisplay: View {
    
    let jobPosting: GJJobPosting
    
    var startDate: Date {
        jobPosting.startDate
    }
    
    var endDate: Date {
        jobPosting.endDate
    }
    
    var body: some View {
        
        Capsule()
            .foregroundStyle(shapeColor)
            .overlay {
                Text(message)
                    .foregroundStyle(.white)
            }
        
    }
    
    var message: String {
        let now = Date.now
        if now < startDate {
            return "before"
        } else if (startDate <= now && now <= endDate) {
            return "In-Progress"
        } else {
            return "complete"
        }
    }
    
    var shapeColor: Color {
        let now = Date.now
        if now < startDate {
            return .blue
        } else if (startDate <= now && now <= endDate) {
            return .green
        } else {
            return .red
        }
    }
    
}

#Preview {
    
    ConvenienceDateDisplay(jobPosting: .init(
        link: .init(),
        companyName: .init(),
        jobPositionName: .init(),
        workplaceLocation: .init(),
        recruitNumbers: .init(), 
        startDate: .init(timeIntervalSinceNow: 10),
        endDate: .init(timeIntervalSinceNow: 500),
        testIds: .init()
    ))
    .frame(width: 150, height: 40)
    
}
