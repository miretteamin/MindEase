//
//  MeditationSession 2.swift
//  LLaMA
//
//  Created by Igor Gogarev on 23.11.2024.
//

import SwiftUI
import AVKit

struct MeditationSession: View {
    let title: String
    let videoFileName: String
    
    @StateObject private var mindWaveViewModel = MindWaveViewModel()
    @StateObject private var musicViewModel: MeditationMusicViewModel
    @State private var player: AVPlayer?
    @State private var isPlaying: Bool = false
    @State private var currentTime: CMTime = .zero
    @State private var totalDuration: CMTime = .zero
    @State private var timeObserver: Any?
    @State private var videoFinished: Bool = false // Track if video has finished

    init(title: String, videoFileName: String) {
        self.title = title
        self.videoFileName = videoFileName
        _musicViewModel = StateObject(wrappedValue: MeditationMusicViewModel(mindWaveViewModel: MindWaveViewModel()))
    }

    var body: some View {
        VStack {
            // Video player view with specific size and content fitting the size
            if let videoURL = Bundle.main.url(forResource: videoFileName, withExtension: "mp4") {
                VideoPlayer(player: player)
                    .frame(width: 320, height: 180) // Set a fixed size for the video
                    .aspectRatio(contentMode: .fill) // Clip content to fill the frame
                    .cornerRadius(12)
                    .padding()
                    .onAppear {
                        setupPlayer(with: videoURL)
                    }
                    .onDisappear {
                        player?.pause() // Pause when the view disappears
                        musicViewModel.stopMeditationMusic() // Stop music when leaving the view
                    }
            } else {
                Text("Video file not found.")
                    .foregroundColor(.red)
                    .padding()
            }

            // Custom Time Tracker
            VStack {
                Text("Time: \(formattedTime(currentTime)) / \(formattedTime(totalDuration))")
                    .font(.title2)
                    .padding()
            }
            
            // Progress Bar
            if totalDuration.seconds > 0 {
                ProgressView(value: CMTimeGetSeconds(currentTime), total: CMTimeGetSeconds(totalDuration))
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding([.leading, .trailing])
            }
            
            // Start/Stop Button
            Button(action: {
                togglePlayback()
            }) {
                Text(isPlaying ? "Pause" : "Start")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(isPlaying ? Color.red : Color.green)
                    .cornerRadius(12)
            }
            .padding()

            // Finish Button that appears when video ends
            if videoFinished {
                Button(action: {
                    // Handle finish action
                    print("Meditation session finished!")
                }) {
                    Text("Finish")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding()
            }

            Spacer()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func setupPlayer(with url: URL) {
        let player = AVPlayer(url: url)
        self.player = player
        
        // Observe the player's current time and duration
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 600), queue: DispatchQueue.main) { time in
            self.currentTime = time
            if self.totalDuration.seconds == 0 {
                self.totalDuration = player.currentItem?.duration ?? .zero
            }
            
            // Check if the video has reached the end
            if CMTimeCompare(time, self.totalDuration) >= 0 {
                self.videoFinished = true // Set the videoFinished flag to true when the video ends
                self.isPlaying = false // Pause the video when it finishes
                handleVideoFinished() // Handle what happens when the video finishes
            }
        }
    }

    private func togglePlayback() {
        guard let player = player else { return }

        if isPlaying {
            player.pause()
            musicViewModel.stopMeditationMusic()
        } else {
            player.play()
            musicViewModel.playIntroMusic()
        }
        
        isPlaying.toggle()
        videoFinished = false // Reset the finish flag when play is toggled
    }

    private func handleVideoFinished() {
        // Call the music view model to get the next audio state
        musicViewModel.updateAudioState()
    }

    private func formattedTime(_ time: CMTime) -> String {
        let seconds = CMTimeGetSeconds(time)
        let minutes = Int(seconds) / 60
        let remainingSeconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}
