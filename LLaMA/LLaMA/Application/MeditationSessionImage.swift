import SwiftUI
import AVFoundation

struct MeditationSessionImage: View {
    @ObservedObject var viewModel = MindWaveViewModel()

    // Use `@StateObject` for `meditationMusicViewModel` and initialize it with `viewModel`
    @StateObject private var musicViewModel: MeditationMusicViewModel

    // Custom initializer to properly initialize `musicViewModel` with `viewModel`
    init() {
        let mindWaveViewModel = MindWaveViewModel()
        _viewModel = ObservedObject(wrappedValue: mindWaveViewModel)
        _musicViewModel = StateObject(wrappedValue: MeditationMusicViewModel(mindWaveViewModel: mindWaveViewModel))
    }

    @State private var remainingTime = 350  // Countdown in seconds
    @State private var isTimerRunning = false
    @State private var navigateToSessionChat = false

    let title: String = "Meditation Session"

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                MainImageView()
                Spacer()

                if viewModel.isConnected {
                    VStack(spacing: 16) {
                        Text("Session in progress")
                            .font(.headline)

                        Text("Time Remaining: \(remainingTime)s")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)

                        HStack(spacing: 20) {
                            Button(isTimerRunning ? "Stop" : "Start") {
                                if isTimerRunning {
                                    stopTimer()
                                } else {
                                    startTimer()
                                }
                            }
                            .font(.system(size: 16, weight: .semibold))
                            .padding()
                            .background(isTimerRunning ? Color.red.opacity(0.8) : Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity) // Expand to fill available width
                            .layoutPriority(1)         // Ensure this button gets equal priority in resizing

                            Button("Finish") {
                                stopTimer()
                                viewModel.disconnectFromMindWave()
                                navigateToSessionChat = true
                                // Handle session finish logic
                            }
                            .font(.system(size: 16, weight: .semibold))
                            .padding()
                            .background(Color.green.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity) // Expand to fill available width
                            .layoutPriority(1)         // Ensure this button gets equal priority in resizing
                        }
                        .frame(maxWidth: .infinity)  // Ensure the HStack spans the entire parent width
                        .padding(.horizontal, 24)

                        NavigationLink(
                            destination: SessionChat(),
                            isActive: $navigateToSessionChat
                        ) {
                            EmptyView()  // No visible UI component
                        }
                    }
                    .padding(16)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                } else {
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("No device found")
                                    .font(.custom("Inter", size: 12))
                                    .fontWeight(.bold)

                                Text("Please connect your headset to start this session.")
                                    .font(.custom("Inter", size: 12))
                                    .foregroundColor(Color(customHex: "494A50"))
                                    .lineSpacing(4)
                                    .kerning(0.12)
                            }
                            Spacer()
                        }
                        Button(action: {
                            viewModel.setupMindWaveDevice()
                            viewModel.connectToMindWave()
                        }) {
                            Text("Connect")
                                .font(.custom("Inter", size: 12))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(customHex: "FFB37C"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(customHex: "FFB37C"), lineWidth: 1.5)
                                )
                        }
                    }
                    .padding(16)
                    .background(Color(customHex: "FFF4E4"))
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                }
            }
            .frame(maxWidth: 480)
            .background(Color.white)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func startTimer() {
        isTimerRunning = true
        musicViewModel.playIntroMusic() // Play intro music when starting the timer

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if !isTimerRunning {
                timer.invalidate()
            } else if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer.invalidate()
                isTimerRunning = false
                // Handle timer completion logic
            }
        }
    }

    private func stopTimer() {
        isTimerRunning = false
        musicViewModel.stopMeditationMusic() // Stop music when the timer is stopped
    }
}

struct MainImageView: View {
    var body: some View {
        Image("tree")
            .frame(height: 500, alignment: .center)
            .edgesIgnoringSafeArea(.all)
            .cornerRadius(16)
            .padding(.vertical, 5)
    }
}

extension Color {
    init(customHex hex: String) {  // Renamed the init function to customHex
        let cleanedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch cleanedHex.count {
        case 3: // 3 digit hex (e.g. #RGB)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // 6 digit hex (e.g. #RRGGBB)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // 8 digit hex (e.g. #RRGGBBAA)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: // Default if the hex format is unrecognized
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
