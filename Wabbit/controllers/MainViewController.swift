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
    let langView = LanguagesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "platinum")
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
        langView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(langView)
        NSLayoutConstraint.activate([
            langView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 3),
            langView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            langView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            langView.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
}

