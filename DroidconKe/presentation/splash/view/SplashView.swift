//
//  SplashView.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack {
            Image(colorScheme == .dark ? .droidconDark : .droidcon)
                .resizable()
                .padding()

            Spacer()

            HStack {
                Text("© Siro Devs")
                    .font(.system(size: 20))
                    .kerning(2)
            }

            Spacer().frame(height: 20)
        }
        .padding()
    }
}

#Preview {
    SplashView()
}
