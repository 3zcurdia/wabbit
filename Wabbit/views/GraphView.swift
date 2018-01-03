//
//  GraphView.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 12/29/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit
import Charts

class GraphView: UIView {
    let reportCellId = "reportGraphCell"

    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Baseline Comparisons"
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "XAxis represent X times slower"
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let reportsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .platinum
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    var reportGroups: [ReportGroup]? {
        didSet {
            DispatchQueue.main.async { self.reportsCollection.reloadData() }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        reportsCollection.register(GraphViewCell.self, forCellWithReuseIdentifier: self.reportCellId)
        reportsCollection.delegate = self
        reportsCollection.dataSource = self
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: CGFloat(20))
            ])

        addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: CGFloat(20))
            ])
        addSubview(reportsCollection)
        NSLayoutConstraint.activate([
            reportsCollection.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            reportsCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            reportsCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            reportsCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

extension GraphView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportGroups?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reportCellId,
                                                            for: indexPath) as? GraphViewCell else { return UICollectionViewCell() }
        guard let unwrapedGroups = reportGroups else { return UICollectionViewCell() }
        cell.reportGroup = unwrapedGroups[indexPath.row]
        return cell
    }
}

extension GraphView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 150.0
        if reportGroups == nil { height = reportsCollection.frame.height }
        return CGSize(width: reportsCollection.frame.width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func invalidateCollectionViewLayout() {
        self.reportsCollection.collectionViewLayout.invalidateLayout()
    }
}
