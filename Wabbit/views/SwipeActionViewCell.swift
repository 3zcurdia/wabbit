//
//  SwipeActionViewCell.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/5/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class SwipeActionViewCell: UICollectionViewCell {
    var text: String? {
        didSet { self.updateText() }
    }

    private let actionTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textColor = .white
        tv.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        tv.textAlignment = .center
        tv.isSelectable = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayouts() {
        addSubview(actionTextView)
        NSLayoutConstraint.activate([
            actionTextView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            actionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            actionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            actionTextView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }

    private func updateText() {
        actionTextView.text = self.text
    }
}
