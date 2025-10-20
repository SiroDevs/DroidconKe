//
//  EmptyState.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import SwiftUI

struct EmptyState: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(.emptyIcon)
                .resizable()
                .frame(width: 200, height: 200)

            Text("Nothing here")
                .font(.title2)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal)

        }
        .padding()
    }
}

#Preview {
    EmptyState()
}
