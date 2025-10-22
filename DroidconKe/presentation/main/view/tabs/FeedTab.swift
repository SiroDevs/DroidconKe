//
//  FeedTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct FeedTab: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    DroidconHeader(showFeedback: true)
                }
            }
            .navigationTitle("Feeds")
            .toolbarBackground(.regularMaterial, for: .navigationBar)
        }
    }
}
