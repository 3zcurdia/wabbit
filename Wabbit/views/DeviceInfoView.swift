//
//  DeviseInfoView.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class DeviceInfoView: UIView {
    var elapsedTime: Double? {
        didSet { updateTime() }
    }
    private let devise = UIDevice.current

    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var iphoneImageView: UIImageView = {
        let iv = UIImageView()
        if devise.modelName == "iPhone X" {
            iv.image = UIImage(named: "iphoneX")!.withRenderingMode(.alwaysTemplate)
        } else {
            iv.image = UIImage(named: "iphone")!.withRenderingMode(.alwaysTemplate)
        }
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let infoTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.isSelectable = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    private let elapsedTimeTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.isSelectable = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        loadInfo()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.backgroundColor = .platinum
        addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
            ])
        container.addSubview(iphoneImageView)
        NSLayoutConstraint.activate([
            iphoneImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            iphoneImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iphoneImageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.8),
            iphoneImageView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8)
            ])
        addSubview(infoTextView)
        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            infoTextView.leadingAnchor.constraint(equalTo: container.trailingAnchor),
            infoTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            infoTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        addSubview(elapsedTimeTextView)
        NSLayoutConstraint.activate([
            elapsedTimeTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            elapsedTimeTextView.leadingAnchor.constraint(equalTo: infoTextView.trailingAnchor),
            elapsedTimeTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            elapsedTimeTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func loadInfo() {
        let foregroundColor = UIColor.black
        let deviseAttributes = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 26),
            NSAttributedStringKey.foregroundColor: foregroundColor
        ]
        let attributedText = NSMutableAttributedString(string: "\(devise.modelName)", attributes: deviseAttributes)
        let systemAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: foregroundColor
        ]
        attributedText.append(NSAttributedString(string: "\n\(devise.systemName) \(devise.systemVersion)\nSwift 4.0", attributes: systemAttributes))
        infoTextView.attributedText = attributedText
    }

    private func updateTime() {
        guard let time = elapsedTime else { return }
        let elapsedAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        let attributedText = NSMutableAttributedString(string: "Elapsed time: \(time.rounded(toDigits: 5) ) [s]", attributes: elapsedAttributes)
        elapsedTimeTextView.attributedText = attributedText
        elapsedTimeTextView.textAlignment = .right
    }
}
