import Foundation
import AVFoundation

class MeditationMusicViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var currentAudioState: String = ""
    private var audioPlayer: AVAudioPlayer?
    private var mindWaveViewModel: MindWaveViewModel

    // Initialize with the MindWaveViewModel instance
    init(mindWaveViewModel: MindWaveViewModel) {
        self.mindWaveViewModel = mindWaveViewModel
    }

    func updateAudioState() {
        // Call updateAudioState from MindWaveViewModel
        mindWaveViewModel.updateAudioState()
        self.currentAudioState = mindWaveViewModel.currentAudio

        // Play the appropriate music if not "closing"
        if currentAudioState != "closing" {
            playMeditationMusic(named: currentAudioState)
        } else {
            stopMeditationMusic()
        }
    }

    func playIntroMusic() {
        playMeditationMusic(named: "intro")
    }

    func playMeditationMusic(named name: String) {
        print(name)
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Error: Could not find music file named \(name)")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
        } catch {
            print("Error: Could not play the audio file named \(name): \(error)")
        }
    }

    func stopMeditationMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }

    // AVAudioPlayerDelegate method called when audio finishes playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if currentAudioState != "closing" {
            updateAudioState() // Update state and play the next track if not closing
        }
    }
}
