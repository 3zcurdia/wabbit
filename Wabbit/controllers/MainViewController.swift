//
//  ViewController.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let exerciseSession = Exercise(times: 10_000, warmup: 5)
    
    let infoView = DeviceInfoView()
    let reportView = ReportView()
    
    let button : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Run!", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        btn.tintColor = .yankeesBlue
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tangerine
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
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
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
        print("Running benchmarks...")
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .background).async {
            self.benchmarkReport(methodName: "Prime", objc: {
                _ = (OBNumeric.shared() as! OBNumeric).isPrimeLong(181)
            }, swift: {
                _ = SWNumeric.shared.isPrime(int: 181)
            })
            
            self.benchmarkReport(methodName: "Factorial", objc: {
                _ = (OBNumeric.shared() as! OBNumeric).factorialLong(13)
            }, swift: {
                _ = SWNumeric.shared.factorial(int: 13)
            })

            let text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean orci lacus, rutrum in purus eget, tristique feugiat erat. Curabitur vulputate orci sollicitudin eros varius pellentesque. Donec id facilisis velit. Nunc dapibus nibh lectus, non condimentum augue gravida ac. In gravida sapien quis eleifend sagittis. Nam sagittis bibendum dui, a accumsan orci placerat eu. Donec eu eros condimentum, rhoncus nibh in, interdum quam. Vivamus nisi turpis, pellentesque at risus quis, feugiat dapibus nunc. Donec volutpat lectus vitae massa sagittis, sit amet commodo massa aliquam. Donec euismod, nisi a aliquam imperdiet, sapien sapien efficitur libero, a lobortis nulla massa vel lectus. Fusce condimentum hendrerit sem vitae malesuada. Phasellus id elit augue. Aenean egestas vitae nulla vel cursus.
            """
            
            self.benchmarkReport(methodName: "SHA1", objc: {
                _ = (OBCrypto.shared() as! OBCrypto).sha1String(text)
            }, swift: {
                _ = SWCrypto.shared.sha1(string:text)
            })

            self.benchmarkReport(methodName: "SHA256", objc: {
                _ = (OBCrypto.shared() as! OBCrypto).sha256String(text)
            }, swift: {
                _ = SWCrypto.shared.sha256(string:text)
            })
            
            self.benchmarkReport(methodName: "Base64", objc: {
                _ = (OBCrypto.shared() as! OBCrypto).base64String(text)
            }, swift: {
                _ = SWCrypto.shared.base64(string:text)
            })
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func benchmarkReport(methodName name:String, objc: @escaping (()->Void), swift: @escaping (()->Void)) {
        print("\n=====\(name)=====")
        let obReport = exerciseSession.run("ObjC", block: objc)
        let swReport = exerciseSession.run("Swift", block: swift)
        
        print(obReport)
        print("\(obReport.ips()) [ips]")
        
        print(swReport)
        print("\(swReport.ips()) [ips]")
        
        let bmFactorial = Benchmark(reports: [obReport, swReport])
        if let comparison = bmFactorial.compare() {
            print(comparison)
        }
    }
}

