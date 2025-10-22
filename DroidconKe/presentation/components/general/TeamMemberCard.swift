//
//  TeamMemberCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 22/10/2025.
//

import SwiftUI

struct TeamMemberCard: View {
    let index: Int
    let teamMembers = [
        ("Frank Tamre", "Nationcom"),
        ("Maxwin Collins", "Nationcom2"),
        ("Jackline", "Main Click"),
        ("John Micronova", "A Hôtel"),
        ("Lincoln", "A Stock"),
        ("Manuel Ceck", "Prix Luxury"),
        ("Kendy or Condy", ""),
        ("Hauru", "Sportola"),
        ("Philomeno", "")
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 60, height: 60)
                .overlay(
                    Text(String(teamMembers[index].0.prefix(1)))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                )
            
            VStack(spacing: 4) {
                Text(teamMembers[index].0)
                    .font(.caption)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                if !teamMembers[index].1.isEmpty {
                    Text(teamMembers[index].1)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

