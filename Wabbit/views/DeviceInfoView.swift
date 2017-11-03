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
    
    private let leftContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iphoneImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "iphone")!.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(named: "platinum")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let infoTextView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
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
        addSubview(leftContainer)
        NSLayoutConstraint.activate([
            leftContainer.topAnchor.constraint(equalTo: topAnchor),
            leftContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
            ])
        
        leftContainer.addSubview(iphoneImageView)
        NSLayoutConstraint.activate([
            iphoneImageView.centerXAnchor.constraint(equalTo: leftContainer.centerXAnchor),
            iphoneImageView.centerYAnchor.constraint(equalTo: leftContainer.centerYAnchor),
            iphoneImageView.heightAnchor.constraint(equalTo: leftContainer.heightAnchor, multiplier: 0.8),
            iphoneImageView.widthAnchor.constraint(equalTo: leftContainer.widthAnchor, multiplier: 0.8)
            ])
        
        addSubview(infoTextView)
        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: topAnchor),
            infoTextView.leadingAnchor.constraint(equalTo: leftContainer.trailingAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    private func loadInfo() {
        let foregroundColor = UIColor(named: "platinum")!
        let attributedText = NSMutableAttributedString(string: "\n\(devise.modelName)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 26), NSAttributedStringKey.foregroundColor: foregroundColor])
        attributedText.append(NSAttributedString(string: "\n\(devise.systemName) \(devise.systemVersion)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: foregroundColor]))
        infoTextView.attributedText = attributedText
    }
}
