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
        VideoPlayer(player: player) {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "play.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .opacity(isPlaying ? 0 : 0.8)
                    Spacer()
                }
                Spacer()
                
                // Optional: Add a muted indicator
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
        .frame(height: 250)
        .cornerRadius(12)
        .padding()
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            player.pause()
            cancellables.removeAll()
        }
    }
    
    private func setupPlayer() {
        let playerItem = AVPlayerItem(url: videoURL)
        player.replaceCurrentItem(with: playerItem)
        
        // Mute the player
        player.isMuted = true
        
        // Use Combine to observe player status
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
            .sink { _ in
                // Loop the video when it ends
                player.seek(to: .zero)
                player.play()
            }
            .store(in: &cancellables)
        
        // Start playing immediately
        player.play()
        
        // Observe play status
        player.publisher(for: \.timeControlStatus)
            .receive(on: RunLoop.main)
            .sink { status in
                isPlaying = status == .playing
            }
            .store(in: &cancellables)
    }
}
