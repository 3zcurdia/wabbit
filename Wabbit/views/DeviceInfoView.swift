//
//  DeviseInfoView.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class DeviceInfoView: UIView {
    private let devise = UIDevice.current
    
    private let container : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iphoneImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "iphone")!.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let infoTextView : UITextView = {
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
        self.backgroundColor = UIColor.tangerine
        addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
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
            infoTextView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            infoTextView.leadingAnchor.constraint(equalTo: container.trailingAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    private func loadInfo() {
        let foregroundColor = UIColor.white
        let attributedText = NSMutableAttributedString(string: "\n\(devise.modelName)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 26), NSAttributedStringKey.foregroundColor: foregroundColor])
        attributedText.append(NSAttributedString(string: "\n\(devise.systemName) \(devise.systemVersion)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: foregroundColor]))
        infoTextView.attributedText = attributedText
    }
}
