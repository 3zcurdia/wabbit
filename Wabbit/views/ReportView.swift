//
//  ReportView.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/3/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ReportView: UIView {
    let reuseIdentifier = "reportCell"
    let reuseActionIdentifier = "actionViewCell"
    let langView : LanguagesView = {
        let lv = LanguagesView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        return lv
    }()
    
    let reportsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.refreshControl = UIRefreshControl()
        cv.refreshControl?.backgroundColor = .platinum
        cv.refreshControl?.addTarget(self, action: #selector(refreshBenchmarks), for: .valueChanged)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var reportGroups : [ReportGroup]? {
        didSet {
            DispatchQueue.main.async { self.reportsCollection.reloadData() }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        reportsCollection.register(ReportViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        reportsCollection.register(SwipeActionViewCell.self, forCellWithReuseIdentifier: self.reuseActionIdentifier)
        reportsCollection.delegate = self
        reportsCollection.dataSource = self
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
        addSubview(reportsCollection)
        NSLayoutConstraint.activate([
            reportsCollection.topAnchor.constraint(equalTo: langView.bottomAnchor),
            reportsCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            reportsCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            reportsCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    @objc func refreshBenchmarks() {
        reportsCollection.refreshControl?.beginRefreshing()
        BenchmarkService.shared.run(onUpdate: { reports in
            self.reportGroups = reports
        }, completion: {
            self.reportsCollection.refreshControl?.endRefreshing()
        })
    }
}

extension ReportView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportGroups?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let unwrapedGroups = reportGroups {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReportViewCell
            cell.reportGroup = unwrapedGroups[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseActionIdentifier, for: indexPath) as! SwipeActionViewCell
            cell.text = "Swipe down to run benchmarks!"
            return cell
        }
    }
}

extension ReportView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height : CGFloat = 125.0
        if reportGroups == nil { height = reportsCollection.frame.height }
        return CGSize(width: reportsCollection.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func invalidateCollectionViewLayout() {
        self.reportsCollection.collectionViewLayout.invalidateLayout()
    }

}
