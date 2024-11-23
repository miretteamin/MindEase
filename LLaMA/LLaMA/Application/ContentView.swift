//
//  ContentView.swift
//  MeditationAppDemo
//
//  Created by Ivan Kozlov on 22/11/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var mindViewModel = MindWaveViewModel()
    var body: some View {
        
        TabView {
            NavigationView {
                Dashboard()
                    .navigationTitle("Meditation Dashboard") // Top bar title
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Meditation", systemImage: "house.fill")
            }
            
            NavigationView {
                ContentView1(mindViewModel: mindViewModel)
                    .navigationTitle("Coach Chat") // Top bar title
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Coach", systemImage: "person.fill")
            }
            
//            NavigationView {
//                HeadsetDemo()
//                    .navigationTitle("Headset Demo") // Top bar title
//                    .navigationBarTitleDisplayMode(.inline)
//            }
//            .tabItem {
//                Label("Demo", systemImage: "gearshape.fill")
//            }
        }
        
    }
}
