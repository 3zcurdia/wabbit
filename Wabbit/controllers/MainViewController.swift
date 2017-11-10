//
//  ViewController.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let infoView = DeviceInfoView()
    let reportView = ReportView()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupLayout() {
        infoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.14)
            ])
        reportView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reportView)
        NSLayoutConstraint.activate([
            reportView.topAnchor.constraint(equalTo: infoView.bottomAnchor),
            reportView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reportView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reportView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            self.reportView.invalidateCollectionViewLayout()
        }, completion: nil)
    }
}
