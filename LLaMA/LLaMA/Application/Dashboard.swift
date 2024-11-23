//
//  Dashboard.swift
//  MeditationAppDemo
//
//  Created by Patrick Tourniaire on 22/11/2024.
//

import SwiftUI

struct UserProfileView: View {
    @State private var user = UserProfile(
        name: "Patrick Tourniaire",
        level: "Novice",
        avatarUrl: "https://media.licdn.com/dms/image/v2/C4E03AQHgS32yPqW24Q/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1627415315555?e=1737590400&v=beta&t=89kpata3FsyamwhF__0nQcpY2UtP6pz-9DRUB--5uyc",
        rating: 2  // Rating out of 5 stars
    )
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                // Avatar image
                AsyncImage(url: URL(string: user.avatarUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .cornerRadius(12)
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(width: 40, height: 40)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    // Name
                    Text(user.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(red: 0.12, green: 0.13, blue: 0.14))
                    
                    // Level
                    Text(user.level)
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.48))
                }
                
                Spacer()
                
                // Rating stars
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < user.rating ? "star.fill" : "star")
                            .foregroundColor(index < user.rating ? Color.blue : Color.blue)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .padding(16)
            .background(Color(red: 0.97, green: 0.98, blue: 1.0))
            .cornerRadius(16)
        }
        .frame(maxWidth: 336)
    }
}

struct UserProfile {
    let name: String
    let level: String
    let avatarUrl: String
    let rating: Int  // Rating out of 5 stars
}


struct MeditationSessionsView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Meditation Sessions")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color( "1F2024"))
                    
                    Spacer()
                    
                    Text("See more")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color( "006FFD"))
                }
                .padding(.horizontal, 8)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CardComponent(
                            title: "Relaxing Ocean",
                            subtitle: "Guided Meditation Coach",
                            imageUrl: "https://fr.ethnasia.com/cdn/shop/articles/sean-o-KMn4VEeEPR8-unsplash_edited.jpg?v=1621585619&width=1100",
                            buttonTitle: "Start",
                            onButtonTap: {
                                print("Start button tapped")
                            },
                            additionalContent: nil,
                            showButton: true
                        )
                        
                        CardComponent(
                            title: "Tranquil Forrest",
                            subtitle: "Guided Meditation Coach",
                            imageUrl: "https://media.istockphoto.com/id/1419410282/photo/silent-forest-in-spring-with-beautiful-bright-sun-rays.jpg?s=612x612&w=0&k=20&c=UHeb1pGOw6ozr6utsenXHhV19vW6oiPIxDqhKCS2Llk=",
                            buttonTitle: "Start",
                            onButtonTap: {
                                print("Start button tapped")
                            },
                            additionalContent: nil,
                            showButton: true
                        )
                    }
                    .padding(.top, 16)
                }
            }
            .frame(maxWidth: 343)
        }
    }
}

struct HistoryView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("History")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color( "1F2024"))
                    
                    Spacer()
                    
                    Text("See more")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color( "006FFD"))
                }
                .padding(.horizontal, 8)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CardComponent(
                            title: "Mountains",
                            subtitle: "Guided Meditation Coach",
                            imageUrl: "https://images.pexels.com/photos/1105389/pexels-photo-1105389.jpeg?cs=srgb&dl=pexels-jplenio-1105389.jpg&fm=jpg",
                            buttonTitle: "Start",
                            onButtonTap: {
                                print("Start button tapped")
                            },
                            additionalContent: AnyView(
                                HStack {
                                    RatingView(rating: 2)
                                    Spacer()
                                    DateView()
                                }
                                .padding(.horizontal, 8)
                            ),
                            showButton: true
                        )

                        CardComponent(
                            title: "Relaxing Ocean",
                            subtitle: "Guided Meditation Coach",
                            imageUrl: "https://fr.ethnasia.com/cdn/shop/articles/sean-o-KMn4VEeEPR8-unsplash_edited.jpg?v=1621585619&width=1100",
                            buttonTitle: "Start",
                            onButtonTap: {
                                print("Start button tapped")
                            },
                            additionalContent: AnyView(
                                HStack {
                                    RatingView(rating: 3)
                                    Spacer()
                                    DateView()
                                }
                                .padding(.horizontal, 8)
                            ),
                            showButton: true
                        )
                    }
                    .padding(.top, 16)
                }
            }
            .frame(maxWidth: 343)
        }
    }
}



struct MeditationCard: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                AsyncImage(url: URL(string: "https://placehold.co/20x20&format=webp")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color( "F8F9FE")
                }
                .frame(height: 120)
                
                HStack {
                    RatingView(rating: 2)
                    
                    DateView()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Forrest Serenity")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color( "1F2024"))
                    
                    Text("Guided Meditation Coach")
                        .font(.system(size: 12))
                        .foregroundColor(Color( "71727A"))
                        .lineSpacing(0)
                }
                
                Button(action: {}) {
                    Text("Start")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(customHex: "006FFD"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color( "006FFD"), lineWidth: 1.5)
                        )
                }
            }
            .padding(16)
        }
        .background(Color("F8F9FE"))
        .cornerRadius(16)
        .frame(width: 250)
    }
}

struct Badge {
    let id: UUID
    let url: String
}


struct RatingView: View {
    let rating: Int // Rating out of 5 (e.g., 3/5 stars)
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<5) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .foregroundColor(index < rating ? Color.white : Color.white)
                    .frame(width: 15, height: 15)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(Color("006FFD"))
        .cornerRadius(12)
    }
}


struct DateView: View {
    var body: some View {
        Text("NOV 22")
            .font(.system(size: 10, weight: .semibold))
            .foregroundColor(.white)
            .kerning(0.5)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .cornerRadius(12)
    }
}


struct Dashboard: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Spacer(minLength: 24);
                UserProfileView();
                Spacer(minLength: 24);
                MeditationSessionsView();
                Spacer(minLength: 12);
                HistoryView()
            }
        }
    }
}

#Preview {
    Dashboard()
}
