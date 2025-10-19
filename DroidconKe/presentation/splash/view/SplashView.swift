//
//  SplashView.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Image(.droidcon)
                .resizable()

            Spacer()

            HStack {
                Text("© Siro Devs")
                    .font(.system(size: 30, weight: .bold))
                    .kerning(5)
                    .foregroundColor(.onPrimaryContainer)
            }

            Spacer().frame(height: 20)
        }
        .padding()
        .background(.onPrimary)
    }
}

#Preview {
    SplashView()
}
