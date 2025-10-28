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
    let videoURL = URL(string: AppConstants.videoUrl)!
    @State private var player = AVPlayer()
    @State private var isPlaying = false
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VideoPlayer(player: player) {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.1))
                                .foregroundColor(.white)
                                .opacity(isPlaying ? 0 : 0.8)
                            Spacer()
                        }
                        Spacer()
                        
                        HStack {
                            Image(systemName: "speaker.slash.fill")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(4)
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .frame(height: videoHeight(for: geometry.size))
            .cornerRadius(12)
            .padding(.horizontal, horizontalPadding(for: geometry.size))
            .padding(.vertical, verticalPadding(for: geometry.size))
        }
        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 400 : 225)
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
        let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        let isLandscape = size.width > size.height
        
        if isiPad {
            return isLandscape ? 350 : 400
        } else {
            return isLandscape ? 225 : 300
        }
    }
    
    private func horizontalPadding(for size: CGSize) -> CGFloat {
        let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        return isiPad ? 24 : 16
    }
    
    private func verticalPadding(for size: CGSize) -> CGFloat {
        let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        return isiPad ? 12 : 8
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
                player.play()
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
