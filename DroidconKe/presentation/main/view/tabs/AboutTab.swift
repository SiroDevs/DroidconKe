//
//  FeedTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct AboutTab: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    
                }
            }
            .navigationTitle("Feeds")
            .toolbarBackground(.regularMaterial, for: .navigationBar)
        }
    }
}
