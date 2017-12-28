//
//  StartViewController.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 12/27/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    var running : Bool = false
    var reports = [ReportGroup]()
    let loader : LoaderView = {
        let view = LoaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let label : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .platinum
        lbl.text = "Tap to start benchmark"
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yankeesBlue
        loader.shapeCenter = view.center
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.heightAnchor.constraint(equalTo: view.heightAnchor),
            loader.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
            ])
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapViewHandler)))
    }
    
    @objc func tapViewHandler() {
        if running { return }
        running = true
        label.text = "running"
        runBenchmarks { elapsedTime in
            self.running = false
            DispatchQueue.main.async { [weak self] in
                self?.label.text = "completed"
                let mainViewController = MainViewController()
                mainViewController.reports = self?.reports
                mainViewController.elapsedTime = elapsedTime
                self?.present(mainViewController, animated: true, completion: nil)
            }
        }
    }
    
    func runBenchmarks(completion: @escaping ((Double) -> Void)) {
        let startTime = Date()
        self.loader.progress = 0
        BenchmarkService.shared.run(onUpdate: { results in
            self.reports = results
            self.loader.progress = CGFloat(results.count) / CGFloat(12.0)
        }, completion: {
            completion(Date().timeIntervalSince(startTime))
        })
    }
}
