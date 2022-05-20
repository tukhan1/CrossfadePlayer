//
//  CFAudioPlayer.swift
//  CrossfadePlayer
//
//  Created by Egor Tushev on 24.04.2022.
//

import AVFoundation

final class CFAudioPlayer {

    private var firstPlayer: AVAudioPlayer?
    private var secondPlayer: AVAudioPlayer?

    private lazy var players: [AVAudioPlayer?] = [firstPlayer, secondPlayer]

    private let timer = DispatchSource.makeTimerSource()

    private var newTimer: Timer?

    deinit {
        stopPlay()
    }

    func startPlayAudio(first audio1: String, second audio2: String ,withFade crossFade: Double, complition: @escaping (Result<String, CFError>) -> Void) {
        timer.activate()
        if let audioUrl = self.makerUrlBy(name: audio1) {
            do {
                players[0] = try AVAudioPlayer(contentsOf: audioUrl)

                if let player = players[0] {
                    player.prepareToPlay()
                    player.volume = 0
                    player.play()
                    player.setVolume(1, fadeDuration: crossFade)

                    newTimer = Timer.scheduledTimer(withTimeInterval: player.duration - crossFade,
                                                    repeats: false) { [weak self] timer in
                        guard let self = self else {
                            complition(.failure(CFError.playerError))
                            return
                        }
                        player.setVolume(0, fadeDuration: crossFade)
                        self.players.reverse()
                        self.startPlayAudio(first: audio2, second: audio1, withFade: crossFade, complition: complition)
                    }

                    complition(.success("OKEY LETS GO"))
                } else {
                    complition(.failure(CFError.playerError))
                    return
                }
            } catch {
                print(error)
                complition(.failure(CFError.playerError))
                return
            }
        } else {
            complition(.failure(CFError.invalidAudioName))
            return
        }
    }

    func isPlaing() -> Bool {
        if let player1 = players[0] {
            if player1.isPlaying {
                return true
            }
        }
        if let player2 = players[1] {
            if player2.isPlaying {
                return true
            }
        }
        return false
    }

    func stopPlay() {
        players.forEach { player in player?.stop() }

        newTimer?.invalidate()
    }

    private func makerUrlBy(name: String) -> URL? {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else { return nil}
        return URL(fileURLWithPath: path)
    }
}
