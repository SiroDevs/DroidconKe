//
//  FeedTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct FeedTab: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var barHidden = true
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .center, spacing: 10) {
                    DroidconHeader(showFeedback: true)
                }
            }
        }
    }
}
