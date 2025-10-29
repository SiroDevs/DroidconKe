//
//  VideoCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 28/10/2025.
//

import SwiftUI
import AVKit
import Combine

struct VideoCard: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    let videoURL = URL(string: AppConstants.videoUrl)!
    @State private var player = AVPlayer()
    @State private var isPlaying = false
    @State private var cancellables = Set<AnyCancellable>()
    
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    private var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    
    private var vidHeight: CGFloat {
        if isIpad {
            return 550
        } else {
            return isLandscape ? 300 : 200
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VideoPlayer(player: player) {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .font(.system(
                                size: min(vidHeight, vidHeight) * 0.3)
                            )
                            .foregroundColor(.white)
                            .opacity(isPlaying ? 0 : 0.8)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .frame(height: vidHeight)
        .cornerRadius(10)
        .padding(.horizontal, isIpad ? 24 : 16)
        .padding(.vertical, isIpad ? 12 : 8)
        .frame(height: vidHeight)
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            player.pause()
            cancellables.removeAll()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
        }
    }
    
    private func videoHeight(for size: CGSize) -> CGFloat {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let isLandscape = size.width > size.height
        
        if isIpad {
            return isLandscape ? 500 : 400
        } else {
            return isLandscape ? 220 : 225
        }
    }
    
    private func setupPlayer() {
        let playerItem = AVPlayerItem(url: videoURL)
        player.replaceCurrentItem(with: playerItem)
        
        player.isMuted = true
        player.automaticallyWaitsToMinimizeStalling = false
        
        let playerViewController = AVPlayerViewController()
        playerViewController.videoGravity = .resizeAspectFill
        
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
            .sink { _ in
                player.seek(to: .zero)
//                player.play()
            }
            .store(in: &cancellables)
        
        player.publisher(for: \.status)
            .receive(on: RunLoop.main)
            .sink { status in
                if status == .readyToPlay {
                    player.play()
                }
            }
            .store(in: &cancellables)
        
        player.publisher(for: \.timeControlStatus)
            .receive(on: RunLoop.main)
            .sink { status in
                isPlaying = status == .playing
            }
            .store(in: &cancellables)
    }
}

#Preview {
    HomeTabPreview(selectedTab: .constant(.home))
}
