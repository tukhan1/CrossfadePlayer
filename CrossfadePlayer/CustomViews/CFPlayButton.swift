//
//  CFPlayButton.swift
//  CrossfadePlayer
//
//  Created by Egor Tushev on 14.05.2022.
//

import UIKit

final class CFPlayButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        setImage(UIImage(systemName: "play.fill"), for: .normal)
        imageView?.tintColor = .systemBackground
        layer.backgroundColor = UIColor.systemPink.cgColor
        clipsToBounds = true
    }
}
