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
    let langView : LanguagesView = {
        let lv = LanguagesView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        return lv
    }()
    
    let reportsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .yankeesBlue
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var reportGroups : [ReportGroup]? {
        didSet {
            reportsCollection.reloadData()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        reportsCollection.register(ReportViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
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
    
    let textTest = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean orci lacus, rutrum in purus eget, tristique feugiat erat. Curabitur vulputate orci sollicitudin eros varius pellentesque. Donec id facilisis velit. Nunc dapibus nibh lectus, non condimentum augue gravida ac. In gravida sapien quis eleifend sagittis. Nam sagittis bibendum dui, a accumsan orci placerat eu. Donec eu eros condimentum, rhoncus nibh in, interdum quam. Vivamus nisi turpis, pellentesque at risus quis, feugiat dapibus nunc. Donec volutpat lectus vitae massa sagittis, sit amet commodo massa aliquam. Donec euismod, nisi a aliquam imperdiet, sapien sapien efficitur libero, a lobortis nulla massa vel lectus. Fusce condimentum hendrerit sem vitae malesuada. Phasellus id elit augue. Aenean egestas vitae nulla vel cursus.
            """
    
    func runBenchmarks(completion: @escaping (()->Void)) {
        DispatchQueue.global(qos: .background).async {
            let primeGroup = ReportGroup.build("Prime", objcMethod: {
                _ = (OBNumeric.shared() as! OBNumeric).isPrimeLong(181)
            }, swiftMethod: {
                _ = SWNumeric.shared.isPrime(int: 181)
            })

            let factGroup = ReportGroup.build("Factorial", objcMethod: {
                _ = (OBNumeric.shared() as! OBNumeric).factorialLong(13)
            }, swiftMethod: {
                _ = SWNumeric.shared.factorial(int: 13)
            })

            let sha1Group = ReportGroup.build("SHA1", objcMethod: {
                _ = (OBCrypto.shared() as! OBCrypto).sha1String(self.textTest)
            }, swiftMethod: {
                _ = SWCrypto.shared.sha1(string:self.textTest)
            })

            let sha256Group = ReportGroup.build("SHA256", objcMethod: {
                _ = (OBCrypto.shared() as! OBCrypto).sha256String(self.textTest)
            }, swiftMethod: {
                _ = SWCrypto.shared.sha256(string:self.textTest)
            })

            let base64Group = ReportGroup.build("Base64", objcMethod: {
                _ = (OBCrypto.shared() as! OBCrypto).base64String(self.textTest)
            }, swiftMethod: {
                _ = SWCrypto.shared.base64(string:self.textTest)
            })
            
            DispatchQueue.main.async {
                self.reportGroups = [primeGroup, factGroup, sha1Group, sha256Group, base64Group]
                completion()
            }
        }
    }
    
}

extension ReportView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReportViewCell
        cell.reportGroup = reportGroups?[indexPath.row]
        return cell
    }
}

extension ReportView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: reportsCollection.frame.width, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
