//
//  ViewController.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var elapsedTime : Double! {
        didSet {
            self.reportView.infoView.elapsedTime = elapsedTime
        }
    }
    var reports : [ReportGroup]! {
        didSet {
            self.reportView.reportGroups = reports
            self.graphView.reportGroups = reports
        }
    }

    private let reuseIdentifier = "PageCell"
    private let pageControl : UIPageControl = {
        let pg = UIPageControl()
        pg.currentPage = 0
        pg.numberOfPages = 2
        pg.currentPageIndicatorTintColor = .yankeesBlue
        pg.pageIndicatorTintColor = UIColor.yankeesBlue.lighten(by: 0.6).opaque(by: 0.6)
        return pg
    }()
    let reportView : ReportView = {
        let rv = ReportView()
        rv.translatesAutoresizingMaskIntoConstraints = false
        return rv
    }()
    let graphView : GraphView = {
        let view = GraphView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.init(collectionViewLayout: layout)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let collection = collectionView else { return }

        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        collection.isPagingEnabled = true

        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .platinum
        let navControllerView = UIStackView(arrangedSubviews: [pageControl])
        navControllerView.translatesAutoresizingMaskIntoConstraints = false
        navControllerView.distribution = .fillEqually
        view.addSubview(navControllerView)
        NSLayoutConstraint.activate([
            navControllerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            navControllerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navControllerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navControllerView.heightAnchor.constraint(equalToConstant: 30)
            ])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .platinum
        if indexPath.row == 0 {
            cell.contentView.addSubview(reportView)
            NSLayoutConstraint.activate([
                reportView.topAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.topAnchor),
                reportView.leadingAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.leadingAnchor),
                reportView.trailingAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.trailingAnchor),
                reportView.bottomAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.bottomAnchor)
            ])
            return cell
        } else {
            cell.contentView.addSubview(graphView)
            NSLayoutConstraint.activate([
                graphView.topAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.topAnchor),
                graphView.leadingAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.leadingAnchor),
                graphView.trailingAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.trailingAnchor),
                graphView.bottomAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.bottomAnchor)
                ])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }, completion: nil)
    }
}
