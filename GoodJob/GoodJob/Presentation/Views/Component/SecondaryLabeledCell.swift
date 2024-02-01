//
//  SecondaryLabeledCell.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/29/24.
//

import SwiftUI

struct SecondaryLabeledCell<Content: View>: View {
    
    let key: String
    let content: () -> Content
    
    init(key: String, @ViewBuilder content: @escaping () -> Content) {
        self.key = key
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(NSLocalizedString(key, comment: .init()))
                .font(.caption)
                .foregroundStyle(.secondary)
            content()
                .font(.body)
                .foregroundStyle(.primary)
        }
    }
    
}
