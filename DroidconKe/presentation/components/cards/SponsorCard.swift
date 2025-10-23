//
//  SponsorCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 22/10/2025.
//

import SwiftUI
import SVGKit

struct SponsorCard: View {
    let sponsor: SponsorEntity
    let size: CGSize
    
    var body: some View {
        Group {
            if let logoUrl = sponsor.logo, let url = URL(string: logoUrl) {
                if url.pathExtension.lowercased() == "svg" {
                    SVGImageView(url: url)
                        .frame(width: size.width, height: size.height)
                } else {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: size.width, height: size.height)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width, height: size.height)
                        case .failure:
                            placeholderLogo
                        @unknown default:
                            placeholderLogo
                        }
                    }
                }
            } else {
                placeholderLogo
            }
        }
    }
    
    private var placeholderLogo: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: size.width, height: size.height)
            .overlay(
                Text(sponsor.name?.first?.uppercased() ?? "S")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            )
            .cornerRadius(12)
    }
}

struct SVGImageView: View {
    let url: URL
    @State private var svgImage: UIImage?
    
    var body: some View {
        Group {
            if let svgImage = svgImage {
                Image(uiImage: svgImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
                    .onAppear {
                        loadSVG()
                    }
            }
        }
    }
    
    private func loadSVG() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                if let svgImage = SVGKImage(data: data) {
                    self.svgImage = svgImage.uiImage
                }
            }
        }.resume()
    }
}
