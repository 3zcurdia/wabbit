//
//  ReportView.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/3/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ReportView: UIView {
    let langView : LanguagesView = {
        let lv = LanguagesView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        return lv
    }()
    
    let reportsView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .platinum
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(langView)
        NSLayoutConstraint.activate([
            langView.topAnchor.constraint(equalTo: topAnchor),
            langView.leadingAnchor.constraint(equalTo: leadingAnchor),
            langView.trailingAnchor.constraint(equalTo: trailingAnchor),
            langView.heightAnchor.constraint(equalToConstant: 44)
            ])
        addSubview(reportsView)
        NSLayoutConstraint.activate([
            reportsView.topAnchor.constraint(equalTo: langView.bottomAnchor),
            reportsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            reportsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            reportsView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
