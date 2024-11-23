//
//  CardComponent.swift
//  MeditationAppDemo
//
//  Created by Patrick Tourniaire on 23/11/2024.
//

import SwiftUI

struct CardComponent: View {
    let title: String
    let subtitle: String
    let imageUrl: String?
    let buttonTitle: String
    let onButtonTap: (() -> Void)?
    let additionalContent: AnyView? // For extra custom content like rating or date
    let showButton: Bool // If the card should include a button
    
    @State private var isNavigating: Bool = false
    let sampleVideoURL = URL(string: "https://www.example.com/sample-video.mp4")!
    
    var body: some View {
        VStack(spacing: 0) {
            // Optional Image
            if let imageUrl = imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 120)
                } placeholder: {
                    Color(customHex: "F8F9FE")
                        .frame(height: 120)
                }
            } else {
                Color(customHex: "F8F9FE")
                    .frame(height: 120)
            }
            
            Spacer(minLength: 12)
            VStack(alignment: .leading, spacing: 12) {
                // Additional content like rating or date
                if let additionalContent = additionalContent {
                    additionalContent
                }

                // Title and Subtitle
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(customHex: "1F2024"))

                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(Color(customHex: "71727A"))
                        .lineSpacing(0)
                }

                // Optional Button
                if showButton {
                    NavigationLink(
                        destination: MeditationSessionImage() // Specify the destination view
                    ) {
                        Text(buttonTitle)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color(customHex: "006FFD"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(customHex: "006FFD"), lineWidth: 1.5)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(16)
        }
        .background(Color(customHex: "F8F9FE"))
        .cornerRadius(16)
        .frame(width: 240)
    }
}

