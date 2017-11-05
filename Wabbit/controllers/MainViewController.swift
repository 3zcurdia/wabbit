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
    
    let button : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Run!", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        btn.backgroundColor = .yankeesBlue
        btn.tintColor = .platinum
        btn.addTarget(self, action: #selector(onTapRun), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let activityIndicator : UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.color = .yankeesBlue
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
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
    
    private func setupLayout(){
        infoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.heightAnchor.constraint(equalToConstant: 140)
            ])
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 64)
            ])
        reportView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reportView)
        NSLayoutConstraint.activate([
            reportView.topAnchor.constraint(equalTo: infoView.bottomAnchor),
            reportView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reportView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reportView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: 5)
            ])
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            activityIndicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 44),
            activityIndicator.widthAnchor.constraint(equalToConstant: 44)
            ])
    }

    @objc func onTapRun() {
        button.isEnabled = false
        activityIndicator.startAnimating()
        reportView.runBenchmarks {
            self.button.isEnabled = true
            self.activityIndicator.stopAnimating()
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            self.reportView.invalidateCollectionViewLayout()
        }, completion: nil)
    }
}

