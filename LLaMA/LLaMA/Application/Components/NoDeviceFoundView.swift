//
//  NoDeviceFoundView.swift
//  MeditationAppDemo
//
//  Created by Patrick Tourniaire on 23/11/2024.
//


import SwiftUI

struct NoDeviceFoundView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: "https://example.com/placeholder-image.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("No device found")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color(red: 0.12, green: 0.13, blue: 0.14))
                        
                        Text("Please connect your headset to start this session.")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.29, green: 0.29, blue: 0.31))
                            .lineSpacing(4)
                    }
                }
                
                Button(action: {
                    // Connect action
                }) {
                    Text("Connect")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(red: 1.0, green: 0.7, blue: 0.49))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(red: 1.0, green: 0.7, blue: 0.49), lineWidth: 1.5)
                        )
                }
                .accessibilityLabel("Connect device")
            }
            .padding(16)
            .background(Color(red: 1.0, green: 0.96, blue: 0.89))
            .cornerRadius(16)
            .frame(maxWidth: 293)
        }
    }
}
