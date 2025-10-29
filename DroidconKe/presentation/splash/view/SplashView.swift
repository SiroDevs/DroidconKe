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
            Spacer()
            Image(.dfCon).padding()
            Image(.droidFlutter).padding(.horizontal, 50)
            
            Spacer().frame(height: 50)
            
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 100)
                .background(.scrim)
            
            Spacer().frame(height: 20)
            
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
