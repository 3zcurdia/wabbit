//
//  ReportView.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class LanguagesView: UIView {
    private let objcImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "objc")!.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .platinum
        iv.backgroundColor = .tangerine
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let swiftImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "swift")!.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.platinum
        iv.backgroundColor = UIColor.tangerine
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        addSubview(objcImageView)
        NSLayoutConstraint.activate([
            objcImageView.topAnchor.constraint(equalTo: topAnchor),
            objcImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            objcImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            objcImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
            ])
        addSubview(swiftImageView)
        NSLayoutConstraint.activate([
            swiftImageView.topAnchor.constraint(equalTo: topAnchor),
            swiftImageView.leadingAnchor.constraint(equalTo: objcImageView.trailingAnchor, constant: -2.0),
            swiftImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            swiftImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

}
