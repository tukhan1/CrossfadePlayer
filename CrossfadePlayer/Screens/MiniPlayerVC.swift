//
//  MiniPlayerVC.swift
//  CrossfadePlayer
//
//  Created by Egor Tushev on 13.05.2022.
//

import UIKit
import SnapKit

final class MiniPlayerVC: UIViewController {
    private let audioTitle: UILabel = UILabel(frame: .zero)
    private let audioSubTitle: UILabel = UILabel(frame: .zero)
    private let playButton: UIButton = UIButton(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(audio: nil)
        makeConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    private func configure(audio: Audio?) {
        audioTitle.text = audio?.title
        audioSubTitle.text = audio?.author
    }

    private func makeConstraints() {
        audioTitle.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(view.snp.top).inset(5)
            make.bottom.equalTo(audioSubTitle.snp.top).offset(5)
            make.right.equalTo(playButton.snp.left).inset(20)
        }
        audioSubTitle.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(20)
            make.bottom.equalTo(view.snp.bottom).inset(5)
            make.right.equalTo(playButton.snp.left).inset(20)
        }
        playButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).inset(20)
            make.top.equalTo(view.snp.top).offset(5)
            make.bottom.equalTo(view.snp.bottom).inset(5)
        }
    }
}
