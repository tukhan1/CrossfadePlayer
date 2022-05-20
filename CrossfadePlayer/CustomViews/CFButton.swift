//
//  CFButton.swift
//  CrossfadePlayer
//
//  Created by Egor Tushev on 24.04.2022.
//

import UIKit

final class CFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        self.backgroundColor = .systemOrange
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        layer.cornerRadius = 8
    }
}
