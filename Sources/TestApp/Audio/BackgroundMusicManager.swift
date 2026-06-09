import AVFoundation
import Foundation

final class BackgroundMusicManager: ObservableObject {
    private var player: AVAudioPlayer?
    private let audioFilename = "bgm"
    private let audioExtension = "mp3"

    init() {
        preparePlayer()
    }

    private func preparePlayer() {
        guard let url = Bundle.module.url(forResource: audioFilename, withExtension: audioExtension) else {
            print("[BGM] bgm.mp3 not found in bundle resources. Add the file to Sources/TestApp/Resources.")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.volume = 0.5
            player?.prepareToPlay()
        } catch {
            print("[BGM] Failed to create AVAudioPlayer: \(error)")
        }
    }

    func start() {
        guard let player else { return }
        if !player.isPlaying {
            player.play()
        }
    }

    func stop() {
        player?.stop()
    }
}
