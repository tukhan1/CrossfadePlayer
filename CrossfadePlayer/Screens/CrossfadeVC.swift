//
//  CrossfadeVC.swift
//  CrossfadePlayer
//
//  Created by Egor Tushev on 24.04.2022.
//

import UIKit
import SnapKit

final class CrossfadeVC: UIViewController {

    private var firstAudioTitle: String = "none"
    private var secondAudioTitle: String = "none"

    private let player: CFAudioPlayer

    private let firstAudioButton: UIButton = CFButton(title: "Choose first audio")
    private let secondAudioButton: UIButton = CFButton(title: "Choose second audio")
    private let crossfadeSlider: UISlider = UISlider(frame: .zero)
    private let crossfadeLabel: UILabel = UILabel(frame: .zero)
    private let playButton: CFPlayButton = CFPlayButton(frame: .zero)

    private let miniPlayer: MiniPlayerVC?

    init(player: CFAudioPlayer) {
        self.player = player
        self.miniPlayer = nil
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makerConstraints()
        addTargets()
    }

    override func viewDidLayoutSubviews() {
        playButton.layer.cornerRadius = playButton.frame.size.width / 2
        crossfadeLabel.layer.cornerRadius = crossfadeLabel.frame.size.width / 2
    }

    private func addTargets() {
        playButton.addTarget(self, action: #selector(playMusic), for: .touchUpInside)

        crossfadeSlider.addTarget(self, action: #selector(crossfadeValueChanged), for: UIControl.Event.valueChanged)

        firstAudioButton.addTarget(self, action: #selector(presentAudioList(by:)), for: .touchUpInside)
        secondAudioButton.addTarget(self, action: #selector(presentAudioList(by:)), for: .touchUpInside)
    }

    @objc private func playMusic() {
        if player.isPlaing() {
            player.stopPlay()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player.startPlayAudio(first: firstAudioTitle,
                                  second: secondAudioTitle,
                                  withFade: Double(crossfadeSlider.value)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let messege):
                    print(messege)
                case .failure(let error):
                    self.presentAlertBy(error: error)
                }
            }
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }

    @objc private func presentAudioList(by sender: UIButton) {
        DispatchQueue.main.async {
            let vc = AudioListVC(firstOrSecond: sender == self.firstAudioButton)
            vc.delegate = self
            vc.navigationItem.title = sender == self.firstAudioButton ? "Choose first audio": "Choose second audio"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func presentAlertBy(error: CFError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .cancel) { action in
                alert.dismiss(animated: true)
            }
            alert.addAction(action)
            self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            self.present(alert, animated: true)
        }
    }

    @objc private func crossfadeValueChanged(sender: UISlider) {
        crossfadeLabel.text = String(format: "%0.1f", crossfadeSlider.value)
    }

    private func configure() {
        view.backgroundColor = .systemBackground

        view.addSubview(playButton)
        view.addSubview(secondAudioButton)
        view.addSubview(firstAudioButton)
        view.addSubview(crossfadeSlider)
        view.addSubview(crossfadeLabel)

        crossfadeSlider.minimumValue = 2
        crossfadeSlider.maximumValue = 10
        crossfadeSlider.maximumTrackTintColor = .systemGray6
        crossfadeSlider.minimumTrackTintColor = .systemOrange
        crossfadeSlider.value = 6

        crossfadeLabel.text = String(format: "%0.1f", crossfadeSlider.value)
        crossfadeLabel.textAlignment = .center
        crossfadeLabel.layer.borderWidth = 4
        crossfadeLabel.layer.borderColor = UIColor.systemOrange.cgColor
        crossfadeLabel.layer.cornerRadius = crossfadeLabel.frame.size.width / 2
    }

    private func makerConstraints() {
        firstAudioButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
            make.height.equalTo(50)
        }
        secondAudioButton.snp.makeConstraints { make in
            make.top.equalTo(firstAudioButton.snp.bottom).offset(30)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
            make.height.equalTo(50)
        }
        playButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.height.equalTo(view.snp.width).multipliedBy(0.18)
        }
        crossfadeSlider.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(50)
            make.bottom.equalTo(crossfadeLabel.snp.top)
        }
        crossfadeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }
    }
}

extension CrossfadeVC: AudioDelegate {
    func setFirstAudio(title: String) {
        firstAudioTitle = title
        firstAudioButton.setTitle(title.replacingOccurrences(of: "-", with: " ").capitalized, for: .normal)
    }

    func setSecondAudio(title: String) {
        secondAudioTitle = title
        secondAudioButton.setTitle(title.replacingOccurrences(of: "-", with: " ").capitalized, for: .normal)
    }
}
