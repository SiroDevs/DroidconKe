//
//  LoadingState.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI
import Lottie

struct LoadingState: View {
    var fileName: String
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 20) {
            DroidconHeader(showFeedback: false)
            
            Spacer()
            
            LottieView(name: fileName)
            
            Spacer()
            
            VStack(spacing: 10) {}
            .frame(height: 20)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    LoadingState(fileName: "developerYoga")
}
