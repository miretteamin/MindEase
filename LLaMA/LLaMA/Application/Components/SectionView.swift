//
//  SectionView.swift
//  MeditationAppDemo
//
//  Created by Patrick Tourniaire on 23/11/2024.
//

import SwiftUI

struct SectionView<Content: View>: View {
    let title: String
    let seeMoreAction: (() -> Void)?
    let items: [Any]
    let content: (Any) -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color("1F2024"))

                Spacer()

                if let seeMoreAction = seeMoreAction {
                    Button(action: seeMoreAction) {
                        Text("See more")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color( "006FFD"))
                    }
                }
            }
            .padding(.horizontal, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                        content(item)
                    }
                }
                .padding(.top, 16)
            }
        }
        .frame(maxWidth: 343)
    }
}

