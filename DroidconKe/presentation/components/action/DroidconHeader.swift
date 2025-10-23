//
//  DroidconHeader.swift
//  DroidconKe
//
//  Created by @sirodevs on 22/10/2025.
//

import SwiftUI

struct DroidconHeader: View {
    let showFeedback: Bool
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack(spacing: 16) {
            Image(colorScheme == .dark ? .droidconLogoWhite : .droidconLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 35)
            
            Spacer()
            if showFeedback {
                
                Button(action: {
                    // handle feedback tap
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "face.smiling")
                        Text("Feedback")
                            .font(.system(size: 15, weight: .medium))
                        Image(.sendIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                    }
                    .foregroundColor(.primary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(.accent)
                    .clipShape(Capsule())
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    DroidconHeader(showFeedback: true)
}
