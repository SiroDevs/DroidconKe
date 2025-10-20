//
//  HomeTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct HomeTab: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    
                }
            }
            .navigationTitle("DroidconKe")
            .toolbarBackground(.regularMaterial, for: .navigationBar)
        }
    }
}
