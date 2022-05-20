//
//  AudioListVC.swift
//  CrossfadePlayer
//
//  Created by Egor Tushev on 24.04.2022.
//

import UIKit
import SnapKit

protocol AudioDelegate: AnyObject {
    func setFirstAudio(title: String)
    func setSecondAudio(title: String)
}

final class AudioListVC: UIViewController {

    weak var delegate: AudioDelegate?

    private var firstOrSecond: Bool

    private let tableView: UITableView = UITableView(frame: .zero)

    private let audios: [Audio] = [
        Audio(title: "jazzy-background-music", author: "DrBre", image: nil),
        Audio(title: "jazz-for-dummies-big-band-guitar", author: "XxxTentapon", image: nil),
        Audio(title: "jazzy-abstract-beat", author: "Jey Pi", image: nil),
        Audio(title: "jingle-bells-jazzy-style-christmas-swing-music", author: "Brake", image: nil),
        Audio(title: "the-epic-trailer", author: "Linkoln Prank", image: nil),
        Audio(title: "lo-fi-beauty", author: "3pac", image: nil)
    ]

    init(firstOrSecond: Bool) {
        self.firstOrSecond = firstOrSecond
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        configure()
    }

    private func configure() {
        view.addSubview(tableView)

        tableView.separatorStyle = .none

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }

        tableView.register(AudioCell.self, forCellReuseIdentifier: AudioCell.identifier)
    }
}

extension AudioListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        audios.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AudioCell.identifier, for: indexPath) as! AudioCell

        cell.configuration(image: nil, title: audios[indexPath.row].title.replacingOccurrences(of: "-", with: " ").capitalized, subTitile: audios[indexPath.row].author)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if firstOrSecond {
            delegate?.setFirstAudio(title: audios[indexPath.row].title)
        } else {
            delegate?.setSecondAudio(title: audios[indexPath.row].title)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}

final private class AudioCell: UITableViewCell {
    static let identifier = "\(AudioCell.self)"

    private let audioImage = UIImageView(frame: .zero)
    private let audioTitle = UILabel(frame: .zero)
    private let audioSubTitle = UILabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configuration(image: UIImage?, title: String, subTitile: String) {
        audioTitle.text = title
        audioSubTitle.text = subTitile
    }

    private func configure() {
        contentView.addSubview(audioImage)
        contentView.addSubview(audioTitle)
        contentView.addSubview(audioSubTitle)

        audioImage.image = UIImage(named: "default-albom-img")
        audioTitle.textAlignment = .left
        audioSubTitle.textAlignment = .left
        audioTitle.lineBreakMode = .byTruncatingTail
        audioTitle.font = .preferredFont(forTextStyle: .headline)
        audioSubTitle.font = .preferredFont(forTextStyle: .footnote)
    }

    private func makeConstraints() {
        audioImage.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.width.height.equalTo(55)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        audioTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(audioImage.snp.right)
            make.right.equalTo(contentView.snp.right).inset(20)
            make.bottom.equalTo(audioSubTitle.snp.top)
        }
        audioSubTitle.snp.makeConstraints { make in
            make.left.equalTo(audioImage.snp.right)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
            make.right.equalTo(contentView.snp.right).inset(20)
        }
    }
}
