//
//  ConvenienceDateDisplay.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/29/24.
//

import SwiftUI


struct ConvenienceDateDisplay: View {
    
    let date: Date
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(shapeColor)
            .overlay {
                Text(message)
            }
        
    }
    
    var message: String {
        (date < .now) ? "End":"Ing"
    }
    
    var shapeColor: Color {
        (date < .now) ? .red:.green
    }
    
}


#Preview {
    ConvenienceDateDisplay(date: .init(timeIntervalSinceNow: -20))
}
